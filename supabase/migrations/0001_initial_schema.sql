create extension if not exists "pgcrypto";

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text unique,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.manga (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text,
  cover_path text,
  status text,
  type text,
  year integer,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.genres (
  id uuid primary key default gen_random_uuid(),
  name text not null unique
);

create table if not exists public.manga_genres (
  manga_id uuid not null references public.manga(id) on delete cascade,
  genre_id uuid not null references public.genres(id) on delete cascade,
  primary key (manga_id, genre_id)
);

create table if not exists public.sources (
  id text primary key,
  name text not null,
  base_url text,
  enabled boolean not null default true,
  status text not null default 'unknown',
  failure_count integer not null default 0,
  last_success_at timestamptz,
  last_failure_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.source_manga (
  id uuid primary key default gen_random_uuid(),
  manga_id uuid not null references public.manga(id) on delete cascade,
  source_id text not null references public.sources(id) on delete cascade,
  external_id text not null,
  external_url text,
  title_on_source text,
  last_synced_at timestamptz,
  created_at timestamptz not null default now(),
  unique (source_id, external_id)
);

create table if not exists public.chapters (
  id uuid primary key default gen_random_uuid(),
  manga_id uuid not null references public.manga(id) on delete cascade,
  source_manga_id uuid references public.source_manga(id) on delete set null,
  number numeric not null,
  title text,
  published_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (manga_id, number, source_manga_id)
);

create table if not exists public.chapter_pages (
  id uuid primary key default gen_random_uuid(),
  chapter_id uuid not null references public.chapters(id) on delete cascade,
  page_number integer not null,
  storage_path text not null,
  width integer,
  height integer,
  created_at timestamptz not null default now(),
  unique (chapter_id, page_number)
);

create table if not exists public.reading_progress (
  user_id uuid not null references auth.users(id) on delete cascade,
  manga_id uuid not null references public.manga(id) on delete cascade,
  chapter_id uuid references public.chapters(id) on delete set null,
  page_number integer not null default 1,
  progress numeric not null default 0,
  updated_at timestamptz not null default now(),
  primary key (user_id, manga_id)
);

create table if not exists public.bookmarks (
  user_id uuid not null references auth.users(id) on delete cascade,
  manga_id uuid not null references public.manga(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (user_id, manga_id)
);

create table if not exists public.reading_history (
  id bigint generated always as identity primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  manga_id uuid not null references public.manga(id) on delete cascade,
  chapter_id uuid references public.chapters(id) on delete set null,
  opened_at timestamptz not null default now()
);

create table if not exists public.sync_jobs (
  id bigint generated always as identity primary key,
  type text not null,
  source_id text references public.sources(id) on delete set null,
  entity_id text,
  status text not null default 'pending',
  attempts integer not null default 0,
  next_attempt_at timestamptz not null default now(),
  last_error text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists idx_chapters_manga_number on public.chapters (manga_id, number desc);
create index if not exists idx_source_manga_manga on public.source_manga (manga_id);
create index if not exists idx_progress_updated on public.reading_progress (updated_at desc);
create index if not exists idx_history_user_opened on public.reading_history (user_id, opened_at desc);
create index if not exists idx_sync_jobs_due on public.sync_jobs (status, next_attempt_at);

alter table public.profiles enable row level security;
alter table public.manga enable row level security;
alter table public.genres enable row level security;
alter table public.manga_genres enable row level security;
alter table public.sources enable row level security;
alter table public.source_manga enable row level security;
alter table public.chapters enable row level security;
alter table public.chapter_pages enable row level security;
alter table public.reading_progress enable row level security;
alter table public.bookmarks enable row level security;
alter table public.reading_history enable row level security;
alter table public.sync_jobs enable row level security;

create policy "public read manga" on public.manga for select to anon, authenticated using (true);
create policy "public read genres" on public.genres for select to anon, authenticated using (true);
create policy "public read manga genres" on public.manga_genres for select to anon, authenticated using (true);
create policy "public read sources" on public.sources for select to anon, authenticated using (enabled = true);
create policy "public read source manga" on public.source_manga for select to anon, authenticated using (true);
create policy "public read chapters" on public.chapters for select to anon, authenticated using (true);
create policy "public read pages" on public.chapter_pages for select to anon, authenticated using (true);

create policy "own profile select" on public.profiles for select to authenticated using ((select auth.uid()) = id);
create policy "own profile update" on public.profiles for update to authenticated using ((select auth.uid()) = id) with check ((select auth.uid()) = id);

create policy "own progress select" on public.reading_progress for select to authenticated using ((select auth.uid()) = user_id);
create policy "own progress insert" on public.reading_progress for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "own progress update" on public.reading_progress for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);

create policy "own bookmarks select" on public.bookmarks for select to authenticated using ((select auth.uid()) = user_id);
create policy "own bookmarks insert" on public.bookmarks for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "own bookmarks delete" on public.bookmarks for delete to authenticated using ((select auth.uid()) = user_id);

create policy "own history select" on public.reading_history for select to authenticated using ((select auth.uid()) = user_id);
create policy "own history insert" on public.reading_history for insert to authenticated with check ((select auth.uid()) = user_id);
