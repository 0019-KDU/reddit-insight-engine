# Compliance

This document records engineering controls. It is not legal advice, and it does not establish
that any particular use of Reddit data is permitted. Current status and evidence are in
[assumptions.md](assumptions.md).

## Current status

- This project holds **no** Reddit approval or API credentials.
- The default data source is synthetic fixtures. No Reddit data is collected.
- New public API requests reportedly closed on 31 October 2026.

## Checklist before enabling `RIE_DATA_SOURCE=reddit`

All items are required. Keep the evidence somewhere private, outside this repository.

- [ ] Read the complete current Data API Terms, Responsible Builder Policy and User Agreement.
- [ ] Hold written approval from Reddit that covers this exact use case and access scope.
- [ ] Confirm the use is not research that must go through Reddit for Researchers.
- [ ] Confirm the access route remains available, given the March 2027 reported closure.
- [ ] Set the retention and reconcile settings from the actual terms, not the defaults.
- [ ] Register a descriptive User-Agent as Reddit's current rules require.
- [ ] Confirm the subreddit allowlist contains only public communities in scope.
- [ ] Identify a person responsible for deletion requests and incident response.
- [ ] Review subreddit rules for communities that restrict automated collection.

Setting `RIE_REDDIT_ACCESS_ACKNOWLEDGED=true` records the operator's statement that this
checklist is complete. It is a guard against accidental activation. It grants nothing.

## Data classification

| Class | Examples | Handling |
| --- | --- | --- |
| Secret | OAuth secret, DB password, author hash key | Environment or secret manager only; never logged |
| Personal | Reddit usernames | Replaced by keyed hash before persistence; raw value discarded |
| Restricted content | Post and comment text | Retention-limited; purged on upstream deletion |
| Metadata | Scores, timestamps, subreddit, fullnames | Retained with its content; only fullname and tombstone survive purge |
| Operational | Run records, metrics | Must not contain restricted content or personal data |

## Handling rules

| Rule | Control | Phase |
| --- | --- | --- |
| Official access only | Only `ContentSource` adapters reach data; no HTML parsing dependency is allowed | 3 |
| Read-only | Application-only OAuth; the port has no write operations | 2, 3 |
| Allowlist | Enforced in the use case, before any source call | 2 |
| Minimization | Only fields listed in the architecture data model are persisted; no raw payloads | 4 |
| Deletion | Reconciliation job purges content and leaves a tombstone | 4 |
| Retention | Scheduled purge past `RIE_RETENTION_DAYS` | 4 |
| Export freshness | Exports carry a manifest with an expiry; stale exports are removed by a purge command | 4 |
| No re-identification | Exports contain the keyed author hash only | 4 |
| No real data in Git | Data paths are ignored; fixtures are synthetic | 1 |

## Known limits

- Once an export leaves the system, this platform cannot delete it. The manifest states the
  obligation, but the recipient must honor it.
- Backups retain purged content until they expire, so backup lifetime must not exceed the
  permitted retention. See the deployment guidance in Phase 7.
- Hashed usernames are pseudonymous, not anonymous. Text content can still identify a person.
