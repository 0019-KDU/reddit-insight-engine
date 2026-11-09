# Assumptions and Risks

Last reviewed: 2026-11-09. Reddit's rules change, so re-check this register before any phase
that touches real access.

## How this was checked

Direct fetches of Reddit's policy pages were refused (HTTP 403), including the Data API Terms
on redditinc.com. Items marked **Reddit (search)** come from Reddit's help-center pages as
returned by a web search, not from reading the complete pages. Nobody has yet read the full
current Data API Terms for this project. A human must do so before enabling real access.

| Evidence level | Meaning |
| --- | --- |
| Reddit (search) | Text from a Reddit help-center page, seen through search results |
| Library docs | Read directly from the library's documentation |
| Secondary | Reported by third parties only |
| Unverified | Prior knowledge; test before relying on it |

## Top risk: real Reddit access may not be obtainable

**Evidence: Reddit (search).** Reddit's 8 October 2026 changelog states:

- New public API access requests stopped being accepted after 31 October 2026.
- Public Data API apps and bots are moving to the Developer Platform (Devvit).
- Access removal begins on 12 January 2027 for apps and users that have not registered or
  responded to Reddit's outreach.
- Remaining public API access ends in March 2027.

Reddit's research guidance adds a second constraint. It states that the Reddit for Researchers
program is the only official and authorized avenue for research using Reddit data, and that
using developer tools or APIs for academic research violates its policies. That program
delivers data through BigQuery Analytics Hub, on a per-project basis, for at most one year.

**Consequences for this project:**

- The PRAW adapter requested for Phase 3 may never be legally usable by this project. It is
  built, but disabled unless the operator confirms approval.
- PRAW-based collection has a reported end date of March 2027, even for approved apps.
- Devvit is reported to run inside subreddits where moderators install an app, so it may not
  fit cross-community collection (**Secondary**).
- A Reddit for Researchers export could feed the same pipeline through a new adapter, but only
  for an approved project and under that program's data rules.

The response is [ADR-0002](../adr/0002-content-source-port-and-gated-access.md): everything
above the `ContentSource` port is independent of how data arrives, and fixture mode keeps the
platform fully demonstrable with no access at all.

## Assumption register

| ID | Assumption | Evidence | If false |
| --- | --- | --- | --- |
| A-01 | This project holds no Reddit approval or credentials today | Project brief | Run the checklist in [compliance.md](compliance.md) |
| A-02 | Explicit approval is required before accessing any Reddit data through the API, including non-commercial use | Reddit (search) | Gate could be relaxed; keep it anyway |
| A-03 | PRAW 8.0.3 is current and supports Python 3.10+ | Library docs | Re-pin and re-test in Phase 3 |
| A-04 | PRAW supports application-only read access through client credentials | Library docs | Revisit NFR-07 |
| A-05 | PRAW follows `X-Ratelimit-*` headers and waits between requests | Library docs | Adapter must throttle itself |
| A-06 | `ratelimit_seconds` (default 5) sets the longest wait PRAW sleeps before raising | Library docs | Change adapter error mapping |
| A-07 | The free tier allows about 100 queries per minute | Secondary | Rely on reported headers, never on this number |
| A-08 | Reddit listings stop at about 1,000 items | Unverified | Adjust backfill expectations |
| A-09 | PRAW's underlying client retries some server errors internally | Unverified | Confirm in Phase 3 so retry layers do not multiply |
| A-10 | Fullnames (`t3_`, `t1_`) are stable unique identifiers | Unverified | Change the deduplication key |
| A-11 | Batched lookup by fullname can detect deletions | Unverified | Redesign reconciliation before real use |
| A-12 | Researchers must not retain data beyond the immediate project and must reflect removals | Reddit (search), for that program | Retention defaults may loosen |
| A-13 | A fixed deletion deadline, such as 48 hours, applies | Secondary; could not be confirmed | Set the reconcile interval from the real terms |
| A-14 | Terms prohibit AI training without permission and unapproved resale | Secondary | Scope exclusions stay regardless |
| A-15 | Single-host batch scale, tens of subreddits and under a few million rows | Project judgment | Revisit partitioning and scheduling |

## Open questions

These must be answered before real access is enabled. Phases 2 to 7 can continue on fixtures.

1. Does the project owner hold a registered, approved app, or Reddit for Researchers approval?
2. Is the intended use "research" in Reddit's sense? Portfolio work on synthetic data is not
   collection at all, but community research on real data may fall under the program above.
3. What deletion deadline and retention period do the current Data API Terms actually impose?

## Sources

- [Changelog - October 8, 2026](https://support.reddithelp.com/hc/en-us/articles/54353370049684-Changelog-October-8-2026)
- [Developer Platform & Accessing Reddit Data](https://support.reddithelp.com/hc/en-us/articles/14945211791892-Developer-Platform-Accessing-Reddit-Data)
- [Reddit for Researchers Program](https://support.reddithelp.com/hc/en-us/articles/49381918834964-Reddit-for-Researchers-Program)
- [Responsible Builder Policy](https://support.reddithelp.com/hc/en-us/articles/42728983564564-Responsible-Builder-Policy)
- [PRAW: rate limits](https://praw.readthedocs.io/en/stable/getting_started/ratelimits.html)
- [PRAW: authentication](https://praw.readthedocs.io/en/stable/getting_started/authentication.html)
- [Secondary report on the access timeline](https://www.how2shout.com/news/reddit-rss-public-api-shutdown-dates.html)
