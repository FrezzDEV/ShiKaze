# ShiKaze architecture

## Goal

Keep the first release small while making the expensive boundaries explicit. The project starts as a modular monolith: one Flutter app, one Render web service, one Supabase project.

## Dependency direction

```text
Presentation -> ViewModel -> Repository contract -> DataSource/infrastructure

Backend route -> application service -> repository -> Supabase
Source adapter -> normalizer -> application service
```

Presentation must never import Supabase or issue raw HTTP/SQL queries. Domain entities must not depend on Flutter, Dio or Supabase.

## Flutter

`apps/mobile/lib/features/*` uses feature-first organization. Each feature may contain `presentation`, `data` and, only when justified, `domain`.

Start without a use-case class for trivial CRUD. Introduce a use case when logic is non-trivial, reused by multiple ViewModels, or needs isolated testing.

Riverpod is used for state and dependency injection. `go_router` owns navigation. DTOs stay in the data layer; domain entities stay stable when API response shapes change.

## Backend

The API is a single Fastify service on Render. Modules are kept independent so long-running ingestion work can later move to a Background Worker without changing client contracts.

Initial modules:

- manga
- chapters
- reader
- library
- history
- auth
- search

The backend owns source adapters, synchronization, normalization, retry handling and privileged Supabase operations.

## Content sources

A `MangaSourceAdapter` is the only backend boundary that knows a source's HTML/API format. Source-specific data is normalized before persistence. `manga` represents the canonical entity; `source_manga` links it to one or more providers.

This prevents provider details from leaking into the Flutter reader and allows a provider to be disabled independently.

## Jobs and scheduling

The first version uses a DB-backed `sync_jobs` table and an in-process scheduler. No Redis, external queue or Render Cron service is required for the initial release.

When the workload exceeds a single API instance, move the job runner to a Render Background Worker and replace scheduling with an external scheduler. The application-level job contract stays the same.

## Storage

Chapter pages are represented in Postgres by metadata (`chapter_pages`) and stored as objects. Flutter code talks to an `ImageStorage` abstraction so object storage can move from Supabase Storage to S3/R2 later if egress or scale makes that worthwhile.

## Offline

Do not implement full offline-first synchronization initially. Keep the reader boundary split between remote content and local storage so downloaded chapters and reading progress can be added without changing the reader UI contract.

## Security

- Only publishable Supabase keys are allowed in the client.
- Service-role/secret keys are backend-only.
- RLS is enabled on every exposed application table.
- User-owned rows are restricted with `auth.uid()` ownership policies.
- Schema changes are committed as Supabase migrations.

## Growth triggers

Add infrastructure only when a measured bottleneck exists:

- slow search -> dedicated search index
- high DB read pressure -> cache
- long sync jobs -> Background Worker
- multiple API instances -> external scheduler/queue
- high image egress -> evaluate R2/S3/CDN

## First delivery milestone

1. Connect the Flutter shell and real routing.
2. Add Supabase project configuration without secrets in git.
3. Implement manga/chapter repositories and API endpoints.
4. Implement one legal/authorized content source adapter.
5. Implement reader + progress + bookmarks + history.
6. Add ingestion retries and source health.
7. Add offline downloads only after online reading is stable.
