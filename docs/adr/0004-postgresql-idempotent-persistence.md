# ADR-0004: PostgreSQL with idempotent upserts

- **Status:** Accepted
- **Date:** 2026-11-09

## Context

Runs overlap on purpose, can be interrupted, and will be replayed. Duplicates must be
impossible rather than merely unlikely.

## Decision

Use PostgreSQL with SQLAlchemy 2 and Alembic through the psycopg 3 driver. Reddit fullnames are
the natural primary keys. Writes use `INSERT ... ON CONFLICT DO UPDATE`, conditional on a
`content_hash`. Each batch and its checkpoint commit in one transaction. Migrations run as an
explicit step and never at application start.

## Alternatives considered

- **SQLite:** simple, but lacks advisory locks and diverges from production behavior.
- **Application-side duplicate checks:** racy, and needs more round trips.
- **Surrogate keys with a unique index:** adds a column with no current benefit.
- **Append-only event history:** conflicts with the duty to erase deleted content.

## Consequences

- Replays are safe, so recovery is simply running again.
- Upserts are PostgreSQL-specific, which is accepted since the database is a deliberate choice.
- The design depends on fullname stability (assumption A-10).
