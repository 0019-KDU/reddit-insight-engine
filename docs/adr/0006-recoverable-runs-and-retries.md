# ADR-0006: Checkpointed runs and bounded retries

- **Status:** Accepted
- **Date:** 2026-11-09

## Context

Long collections can meet transient faults, revoked credentials, restricted subreddits and
process termination. Each needs a different response, and retries must not become abuse.

## Decision

- Track each execution in `ingestion_run`, with per-scope records in `ingestion_failure`.
- Commit each batch with its checkpoint, and stop on signals only at batch boundaries.
- Use a PostgreSQL advisory lock to permit one collection at a time.
- Classify errors as defined in the [failure policy](../architecture/overview.md#failure-policy).
- Retry only transient errors, using capped exponential backoff with full jitter. Limit both
  attempts per request and total failures per run.
- Implement retries with `tenacity`, injecting sleep for deterministic tests.

## Alternatives considered

- **Workflow engine such as Airflow or Temporal:** more operations than one pipeline justifies.
- **External queue:** a checkpoint table already gives recoverability.
- **Unbounded or fixed-delay retries:** risks hammering the API.

## Consequences

- Recovery needs no special procedure: rerun the command.
- Records collected before an interruption remain valid, so a run can be partly complete. The
  `partial` and `interrupted` statuses make this visible.
- Scheduling is left to the host, such as cron or a Kubernetes CronJob.
