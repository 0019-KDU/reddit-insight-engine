# Requirements

Status values: **Planned** (not built), **Done** (built and tested). Every requirement is
Planned at the end of Phase 1 unless marked otherwise.

## Purpose

Collect, process, store and analyze data from an allowlisted set of developer, DevOps, SRE,
cloud, infrastructure, security, AI and software engineering communities, using only access
that Reddit has approved. The platform must be fully usable without real Reddit access.

## Stakeholders

| Role | Needs |
| --- | --- |
| Operator | Runs collections safely, diagnoses failures, resumes interrupted runs |
| Analyst | Trustworthy summaries and exports that reflect deletions |
| Contributor | Develops and tests without credentials |
| Reddit and its users | Limits, terms, deletion and privacy are respected |

## Functional requirements

| ID | Requirement | Acceptance criteria | Phase |
| --- | --- | --- | --- |
| FR-01 | Subreddit allowlist | Collection refuses any subreddit not in configuration | 2 |
| FR-02 | Collect permitted post metadata | Posts are retrieved through the `ContentSource` port | 3 |
| FR-03 | Collect permitted comments | Comments are bounded per post and linked to the post | 3 |
| FR-04 | Pagination and limits | Per-subreddit and per-post limits are never exceeded | 3 |
| FR-05 | Normalization and validation | Invalid records are quarantined and do not stop the run | 4 |
| FR-06 | Deduplication and idempotency | Re-running over identical input changes no row content | 4 |
| FR-07 | PostgreSQL persistence | Writes are transactional; schema changes use Alembic | 4 |
| FR-08 | CSV and JSON export | Exports are pseudonymized and carry a manifest | 4 |
| FR-09 | Run and failure tracking | Every run and failure is queryable by run ID | 2, 4 |
| FR-10 | Incremental collection | A later run fetches only records past the checkpoint, plus overlap | 4 |
| FR-11 | Summaries and analytics | Volume, activity, top terms and engagement per subreddit | 4 |
| FR-12 | Deletion reconciliation | Content deleted upstream is purged locally on the next pass | 4 |
| FR-13 | Retention enforcement | Content older than the retention window is purged | 4 |
| FR-14 | Fixture mode | All use cases run end to end with no credentials or network | 3 |

## Non-functional requirements

| ID | Category | Requirement | Phase |
| --- | --- | --- | --- |
| NFR-01 | Rate limits | Honor limits reported by the API; never try to evade them | 3 |
| NFR-02 | Retries | Transient failures use bounded exponential backoff with jitter | 3 |
| NFR-03 | Failure handling | Authentication and permission failures are distinct and never retried blindly | 3 |
| NFR-04 | Recoverability | SIGINT or SIGTERM stops at a batch boundary; the next run resumes | 4 |
| NFR-05 | Concurrency | Only one collection runs per database at a time | 4 |
| NFR-06 | Secrets | No secret in source, logs, exports or images | 1 onward |
| NFR-07 | Least privilege | Application-only read access; no Reddit user password is ever accepted | 3 |
| NFR-08 | Maintainability | Layer rules are enforced in CI; code is strictly typed | 1 onward |
| NFR-09 | Observability | JSON logs with run and correlation IDs; metrics for requests, failures, retries, records and duration | 7 |
| NFR-10 | Supply chain | Locked dependencies, vulnerability scanning and SBOM generation | 1, 6 |
| NFR-11 | Testing | Unit, integration and adapter tests with coverage reporting | 5 |

## Out of scope

- HTML scraping, unofficial endpoints, or third-party scraping services.
- Writing to Reddit in any form: posting, voting, messaging or moderation.
- Private, quarantined or otherwise restricted communities.
- Using collected content to train machine-learning models.
- Profiling or identifying individual Reddit users.
- Selling, sublicensing or redistributing collected data.
- Microservices, streaming pipelines, and an HTTP API until a real need appears
  ([ADR-0007](../adr/0007-cli-first-and-sql-analytics.md)).
