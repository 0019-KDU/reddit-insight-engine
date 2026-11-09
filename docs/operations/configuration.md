# Configuration

All configuration comes from environment variables, loaded through Pydantic Settings once it
is implemented. This page is the contract for later phases. [`.env.example`](../../.env.example)
must stay in step with it. Secrets must come from the environment or a secret manager, never
from files committed to Git.

## Runtime

| Variable | Default | Secret | Description |
| --- | --- | --- | --- |
| `RIE_ENVIRONMENT` | `local` | No | `local`, `ci` or `production` |
| `RIE_LOG_LEVEL` | `INFO` | No | Standard logging level |

## Data source

| Variable | Default | Secret | Description |
| --- | --- | --- | --- |
| `RIE_DATA_SOURCE` | `fixture` | No | `fixture` or `reddit` |
| `RIE_FIXTURE_PATH` | `tests/fixtures/reddit` | No | Synthetic data directory |
| `RIE_REDDIT_ACCESS_ACKNOWLEDGED` | `false` | No | Operator's statement that the [compliance checklist](../architecture/compliance.md) is complete |
| `RIE_REDDIT_CLIENT_ID` | none | Yes | Approved application's client ID |
| `RIE_REDDIT_CLIENT_SECRET` | none | Yes | Approved application's secret |
| `RIE_REDDIT_USER_AGENT` | none | No | Descriptive User-Agent, as Reddit's current rules require |

## Collection

| Variable | Default | Secret | Description |
| --- | --- | --- | --- |
| `RIE_SUBREDDIT_ALLOWLIST` | none | No | Comma-separated names; collection refuses all others |
| `RIE_COLLECT_MAX_POSTS_PER_SUBREDDIT` | `100` | No | Maximum posts per subreddit per run |
| `RIE_COLLECT_MAX_COMMENTS_PER_POST` | `200` | No | Maximum comments per post |
| `RIE_COLLECT_PAGE_SIZE` | `100` | No | Records per page and per transaction |
| `RIE_COLLECT_REPLACE_MORE_LIMIT` | `0` | No | Comment expansions per post; each costs API requests |
| `RIE_COLLECT_OVERLAP_MINUTES` | `60` | No | Look-back past the high watermark |

## Retries

| Variable | Default | Secret | Description |
| --- | --- | --- | --- |
| `RIE_RETRY_MAX_ATTEMPTS` | `5` | No | Attempts per request, including the first |
| `RIE_RETRY_BASE_DELAY_SECONDS` | `1.0` | No | Initial backoff ceiling |
| `RIE_RETRY_MAX_DELAY_SECONDS` | `60.0` | No | Maximum backoff |

## Database

| Variable | Default | Secret | Description |
| --- | --- | --- | --- |
| `RIE_DATABASE_URL` | none | Yes | SQLAlchemy URL using the `psycopg` driver |

## Privacy and retention

The defaults are conservative placeholders. Set real values from the current terms.

| Variable | Default | Secret | Description |
| --- | --- | --- | --- |
| `RIE_AUTHOR_HASH_KEY` | none | Yes | HMAC key for author pseudonymization |
| `RIE_RETENTION_DAYS` | `30` | No | Content older than this is purged |
| `RIE_DELETION_RECONCILE_INTERVAL_HOURS` | `24` | No | Longest allowed gap between reconciliations |
| `RIE_EXPORT_DIR` | `exports` | No | Export output directory |
| `RIE_EXPORT_MAX_AGE_DAYS` | `7` | No | Exports older than this are purged |

## Observability

| Variable | Default | Secret | Description |
| --- | --- | --- | --- |
| `RIE_OTEL_ENABLED` | `false` | No | Enables OpenTelemetry export |
| `OTEL_EXPORTER_OTLP_ENDPOINT` | none | No | Standard OpenTelemetry collector endpoint |
