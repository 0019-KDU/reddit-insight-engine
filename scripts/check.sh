#!/usr/bin/env bash
# Runs every local quality gate. Stops at the first failure.
set -euo pipefail

# Without this, tools printing Unicode crash on Windows when output is redirected.
export PYTHONUTF8=1

cd "$(dirname "${BASH_SOURCE[0]}")/.."

uv lock --check
uv run --frozen ruff check .
uv run --frozen ruff format --check .
uv run --frozen mypy
uv run --frozen lint-imports
uv run --frozen pytest --cov --cov-report=term-missing
