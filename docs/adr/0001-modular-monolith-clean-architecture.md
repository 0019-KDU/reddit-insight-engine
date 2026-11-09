# ADR-0001: Modular monolith with enforced layers

- **Status:** Accepted
- **Date:** 2026-11-09

## Context

The workload is a batch pipeline run by a small team on one host. It still has distinct
concerns that change for different reasons, and its data source is unusually unstable.

## Decision

Build one deployable Python package with four layers: domain, application, infrastructure and
interfaces. Dependencies point inward. `import-linter` contracts fail the build on violations,
and forbid frameworks in the domain and application layers.

## Alternatives considered

- **Microservices:** independent scaling is not needed, and network boundaries would add
  deployment and consistency costs with no benefit at this scale.
- **Flat script or package:** cheapest today, but it would tie business logic to PRAW, which is
  the dependency most likely to be replaced.
- **Convention-only layering:** boundaries erode without enforcement.

## Consequences

- Logic is testable without a network or database, and adapters can be replaced in isolation.
- Mapping between layers adds some code, and that is accepted only at real boundaries.
- Any future split into services can follow the existing port boundaries.
