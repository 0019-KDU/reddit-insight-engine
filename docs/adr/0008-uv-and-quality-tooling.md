# ADR-0008: uv and locked quality tooling

- **Status:** Accepted
- **Date:** 2026-11-09

## Context

Builds must be reproducible, and local hooks, CI and developers should not disagree about tool
versions.

## Decision

Use uv with a committed, hash-verified `uv.lock` and PEP 735 dependency groups. Pre-commit runs
Ruff, mypy and import-linter from that lock, rather than from separately pinned hook copies.
Runtime dependencies are added only by the phase that first uses them.

## Alternatives considered

- **pip-tools:** workable, but slower, and needs separate Python and environment management.
- **Poetry:** capable, but uses more non-standard configuration for no added benefit here.

## Consequences

- One command reproduces an environment, and each tool has a single version source.
- Contributors must install uv.
- Hooks need a synced environment, which `uv sync` provides during setup.
