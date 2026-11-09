# ADR-0009: structlog and OpenTelemetry

- **Status:** Accepted
- **Date:** 2026-11-09

## Context

Operators need to answer what a given run did and why it failed. Short-lived batch processes
cannot be scraped reliably, and telemetry must never leak content or secrets.

## Decision

- Emit JSON logs through structlog, binding `run_id` and `correlation_id` to every event, with a
  redaction processor applied last.
- Record metrics and spans behind a `Telemetry` port, implemented with the OpenTelemetry SDK.
  Export by OTLP push when enabled. The default is a no-op.
- Do not attach post text, comment text or usernames to logs, metrics or spans.
- Keep metric attributes low-cardinality: subreddit and outcome are allowed, fullnames are not.

## Alternatives considered

- **Standard library logging alone:** workable, but context binding takes more custom code.
- **Prometheus client:** pull-based scraping suits long-running services, not batch jobs.

## Consequences

- Telemetry can be enabled with no code change and costs nothing when off.
- Run summaries remain available in PostgreSQL even with no collector.
- No health endpoint exists, since there is no service interface (ADR-0007).
