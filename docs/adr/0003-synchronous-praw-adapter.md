# ADR-0003: Synchronous PRAW, confined to one adapter

- **Status:** Accepted
- **Date:** 2026-11-09

## Context

Throughput is capped by the API's rate limit, not by local concurrency. PRAW's documentation
states that it follows `X-Ratelimit-*` headers and waits between requests.

## Decision

Use synchronous PRAW with application-only OAuth, imported only inside one infrastructure
module. The adapter maps PRAW objects to DTOs and library exceptions to domain errors. No
setting for a Reddit username or password will exist.

## Alternatives considered

- **Async PRAW:** concurrency cannot exceed the rate limit, so async would add complexity
  across the stack for no throughput gain.
- **Direct HTTP client:** would reimplement OAuth and rate-limit handling that PRAW provides.

## Consequences

- The pipeline stays sequential and easy to reason about.
- Library rate-limit sleeps block the process, so shutdown may wait for a sleep to finish.
- Whether PRAW's client retries internally must be confirmed in Phase 3
  (assumption A-09), so that retry layers do not multiply.
