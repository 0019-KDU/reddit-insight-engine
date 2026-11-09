# Integration tests

Tests that need real external services, such as PostgreSQL, live here and carry the
`integration` pytest marker. They arrive with persistence in Phase 4.

Integration tests must never call the real Reddit API.
