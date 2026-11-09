# Contributing

## Getting started

Follow [local setup](docs/operations/local-setup.md). You do not need Reddit credentials. Before
opening a pull request, run:

```bash
bash scripts/check.sh
```

## Workflow

- Branch from `main` and use short, descriptive names, such as `feature/retention-purge`.
- Write commit messages in the imperative mood, and keep each commit to one logical change.
- Link each pull request to the requirement it addresses, such as `FR-06`.
- Add an ADR for any decision that is costly to reverse.

## Architecture rules

- Dependencies point inward: interfaces, infrastructure, application, domain.
- The domain imports only the standard library.
- The application imports the domain and defines ports for everything external.
- Third-party types, such as PRAW objects and SQLAlchemy models, stay inside infrastructure.
- All wiring happens in the composition root, through constructor injection.
- Do not add a layer, abstraction or dependency without a current need.

`lint-imports` enforces the layer boundaries. Do not weaken a contract to make a change pass.

## Python standards

- Target Python 3.12 or newer, with `mypy --strict` passing and no blanket `Any`.
- Use frozen dataclasses for domain values and frozen Pydantic models at validated boundaries.
- Use timezone-aware UTC datetimes only.
- Raise specific domain errors. Do not catch bare `Exception`, except at the top-level boundary.
- Add `# type: ignore[code]` or `# noqa: CODE` only with a reason on the same line.
- Use the logger, never `print`.

## Dependencies

- Add runtime dependencies with `uv add`, in the phase that first uses them, and commit `uv.lock`.
- Prefer maintained libraries with a small footprint and an acceptable license.

## Testing

- Unit tests make no network or database calls, and control time and randomness through ports.
- Integration tests are marked `integration` and use real PostgreSQL.
- No automated test may call the real Reddit API.
- Name tests for behavior, and cover failure paths as well as successful ones.
- Fixtures must be synthetic. Never commit real Reddit content or usernames.

## Security and compliance rules

- Never commit secrets, `.env` files or collected data.
- Never log secrets, post or comment text, or usernames.
- Never add HTML scraping, unofficial endpoints, or anything intended to evade limits.
- Changes that affect collected fields, retention or access scope must update
  [compliance.md](docs/architecture/compliance.md) and the
  [threat model](docs/architecture/threat-model.md).
- Report vulnerabilities as described in [SECURITY.md](SECURITY.md), not in public issues.

## Definition of done

- [ ] `bash scripts/check.sh` passes.
- [ ] New behavior has tests, including failure paths.
- [ ] Documentation and `.env.example` reflect the change.
- [ ] No secrets, personal data or real Reddit content are included.
