# Local Setup

## Prerequisites

- [uv](https://docs.astral.sh/uv/)
- Git, and on Windows a Bash shell such as Git Bash for scripts
- Docker, from Phase 4 onward for PostgreSQL

Reddit credentials are not required.

## Set up

```bash
git clone https://github.com/<your-account>/reddit-insight-engine.git
cd reddit-insight-engine
uv sync --frozen
uv run --frozen pre-commit install
cp .env.example .env
```

`uv sync` installs the Python version named in `.python-version` if it is missing. The hooks
also need `gitleaks` to be fetched by pre-commit on their first run, so that run needs network
access.

## Verify

```bash
bash scripts/check.sh
```

This runs the lock check, Ruff, mypy, the architecture import contracts, and pytest with
coverage.

There is no runnable application yet. The CLI arrives in Phase 2.
