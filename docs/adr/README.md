# Architecture Decision Records

ADRs capture decisions that are costly to reverse. Accepted ADRs are not rewritten. To change
one, add a new ADR that supersedes it. Copy [template.md](template.md) to start.

| ADR | Decision | Status |
| --- | --- | --- |
| [0001](0001-modular-monolith-clean-architecture.md) | Modular monolith with enforced layers | Accepted |
| [0002](0002-content-source-port-and-gated-access.md) | Content source port, fixtures first, gated real access | Accepted |
| [0003](0003-synchronous-praw-adapter.md) | Synchronous PRAW, confined to one adapter | Accepted |
| [0004](0004-postgresql-idempotent-persistence.md) | PostgreSQL with idempotent upserts | Accepted |
| [0005](0005-privacy-retention-and-deletion.md) | Pseudonymization, retention and deletion by design | Accepted |
| [0006](0006-recoverable-runs-and-retries.md) | Checkpointed runs and bounded retries | Accepted |
| [0007](0007-cli-first-and-sql-analytics.md) | CLI first, SQL for analytics | Accepted |
| [0008](0008-uv-and-quality-tooling.md) | uv and locked quality tooling | Accepted |
| [0009](0009-observability-structlog-opentelemetry.md) | structlog and OpenTelemetry | Accepted |
