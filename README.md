# ShiKaze

Foundation for a manga reader built as a small-team modular monolith.

## Repository layout

```text
apps/
  mobile/      Flutter application
  api/         TypeScript API + ingestion scheduler
supabase/
  migrations/  PostgreSQL schema and RLS
 docs/
  architecture.md
```

## Architecture rules

1. Presentation never talks to Supabase directly.
2. Features depend on repository contracts, not infrastructure.
3. Domain models do not depend on Flutter, Dio, Supabase or HTTP DTOs.
4. Source adapters are isolated from the reader and catalog.
5. `service_role` / secret keys are backend-only.
6. All user-owned data is protected with RLS.
7. Database changes are migrations, not manual production edits.
8. New infrastructure is added only when measured load requires it.

## First milestone

- one Render Web Service
- Supabase Postgres/Auth/Storage
- one source adapter
- manga catalog + chapter list + reader contract
- reading progress + bookmarks + history
- lightweight DB-backed jobs and an in-process scheduler

See `docs/architecture.md` for the detailed decisions.
