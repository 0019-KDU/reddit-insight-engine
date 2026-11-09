# ADR-0002: Content source port, fixtures first, gated real access

- **Status:** Accepted
- **Date:** 2026-11-09

## Context

The project has no Reddit approval. Reddit's changelog states that new public API requests
closed on 31 October 2026 and that remaining public access ends in March 2027. Reddit also
states that research must go through Reddit for Researchers, which delivers data through
BigQuery Analytics Hub. See [assumptions.md](../architecture/assumptions.md).

## Decision

1. The application depends on a read-only `ContentSource` port, not on Reddit's API shape.
2. A fixture adapter over synthetic data is the default and supports every use case.
3. The PRAW adapter is built as requested, but starts only when `RIE_DATA_SOURCE=reddit`,
   `RIE_REDDIT_ACCESS_ACKNOWLEDGED=true`, and credentials are all present.
4. Port names describe capabilities (list recent posts, fetch comments, check status), so a
   batch export adapter can implement them without pretending to be a paginated API.

## Alternatives considered

- **PRAW directly in use cases:** simplest, but the core would die with the API.
- **Scraping or third-party scraper services:** rejected. These are explicitly out of scope
  and appear aimed at avoiding the restrictions this project must respect.
- **Stop until access exists:** the engineering value does not depend on live access.

## Consequences

- The platform can be built, tested and demonstrated with no credentials.
- The acknowledgement flag is a safety catch, not proof of permission.
- The PRAW adapter may never run in production. Its cost is one module, and it remains useful
  as a reference implementation of the port.
- Fixture mode cannot prove behavior against the real API. Adapter tests against recorded
  synthetic responses reduce that gap but do not close it.
