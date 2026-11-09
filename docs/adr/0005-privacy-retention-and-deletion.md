# ADR-0005: Pseudonymization, retention and deletion by design

- **Status:** Accepted
- **Date:** 2026-11-09

## Context

Community analysis does not require knowing who wrote something. Deleted content must not
persist locally. The exact contractual deadlines could not be confirmed
(assumptions A-12 and A-13), so the design must be configurable and conservative.

## Decision

- Replace usernames with an HMAC-SHA-256 keyed hash before persistence, and discard the original.
- Persist only the fields in the data model. Never store raw API payloads.
- Run a reconciliation job that re-checks stored fullnames and purges content deleted upstream.
- Purge leaves a tombstone: fullname and `deleted_at` only, with content columns nulled.
- Enforce a retention window, defaulting conservatively to 30 days, and expire exports.

## Alternatives considered

- **Store usernames:** enables user-level analysis, which is explicitly out of scope.
- **Unkeyed hash:** usernames are guessable, so a plain hash can be reversed by dictionary.
- **Remove the row entirely:** a later replay could restore the content.
- **Soft delete with content kept:** does not meet the purpose of deletion.

## Consequences

- Per-author distinct counts still work, but no export can name a user.
- Rotating the hash key breaks author continuity, which is acceptable and can be a feature.
- Reconciliation consumes API quota, and its feasibility rests on assumption A-11.
- Thirty days is a placeholder, not a statement of what Reddit requires.
