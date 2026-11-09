# ADR 0001: Local-First Development

Status: Accepted

## Context
The platform needs a reproducible development environment without
requiring paid cloud infrastructure for every iteration.

## Decision
Use Docker and kind for the initial environment. Use GitHub Actions
and GHCR for source automation and image publishing.

## Consequences
- Initial Kubernetes workflows run locally.
- Cloud deployment is a later extension.
- Local resource usage and port conflicts must be managed.
