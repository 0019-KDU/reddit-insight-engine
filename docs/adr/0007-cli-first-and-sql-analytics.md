# ADR-0007: CLI first, SQL for analytics

- **Status:** Accepted
- **Date:** 2026-11-09

## Context

All current consumers are operators, schedulers and analysts using files. The planned
analytics are aggregates over data that already lives in PostgreSQL.

## Decision

Ship a CLI, and exit codes that schedulers can act on. Add no HTTP API or health endpoint until
a concrete consumer exists. Compute analytics in SQL through SQLAlchemy. Do not add Pandas or
Polars until an analysis truly cannot be expressed reasonably in SQL.

## Alternatives considered

- **HTTP API now:** adds authentication, an attack surface and uptime duties with no user.
- **Polars or Pandas now:** moves data out of the database to do what it does well, and adds a
  heavy dependency with its own memory limits.

## Consequences

- There is less to secure and operate.
- Because use cases are independent of the CLI, an API can be added later as another interface.
- Advanced text analysis may later justify a dataframe library. That would be a new ADR.
