# Security Policy

## Supported versions

This project is pre-release. Only the latest commit on `main` receives security fixes.

## Reporting a vulnerability

Please do not open a public issue. Use GitHub's private reporting, under **Security > Report a
vulnerability** on this repository, and include the affected component, reproduction steps and
likely impact.

Never include real credentials or personal data in a report. This is a personal project, so
responses are best-effort.

## Reporting a data concern

To report data that should not be here, such as a real username or post in the repository's
history, use the same private channel.

## Security design

- Credentials come only from the environment or a secret manager.
- Reddit access is application-only and read-only, and no Reddit password setting exists.
- Usernames are replaced with a keyed hash before storage.
- Secret scanning runs before each commit once hooks are installed.

The [threat model](docs/architecture/threat-model.md) lists threats, mitigations and the phase
that delivers each one. Many controls are still planned, as the project is at an early stage.

## If a secret is exposed

1. Revoke or rotate the secret immediately. Deleting the commit is not enough.
2. Remove it from Git history, if it was committed.
3. Review access logs for misuse, where available.
