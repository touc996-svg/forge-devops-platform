# FORGE
## Enterprise Internal Developer Platform & DevSecOps Delivery System

FORGE is a local-first Internal Developer Platform designed to standardize
software delivery, automate infrastructure operations, enforce security
guardrails, and improve developer experience.

## Platform Objectives

- Developer self-service portal
- Software catalog and golden paths
- Automated CI/CD
- Infrastructure as Code
- Kubernetes and Helm
- GitOps deployment automation
- DevSecOps and supply-chain security
- Progressive delivery and rollback
- Metrics, logs, traces and alerts
- SLOs, backup and disaster recovery
- Resource and cost governance

## Technology Stack

| Domain | Technology |
|---|---|
| Developer portal | Backstage |
| Platform API | Python / FastAPI |
| Containers | Docker |
| CI/CD | GitHub Actions |
| Container registry | GHCR |
| Security | Trivy, Gitleaks, pip-audit |
| Infrastructure | Terraform |
| Kubernetes | kind |
| Packaging | Helm |
| GitOps | Argo CD |
| Policy | Kyverno |
| Supply chain | SBOM, Cosign |
| Metrics | Prometheus |
| Dashboards | Grafana |
| Logs | Loki |
| Tracing | OpenTelemetry / Tempo |

## Current Implementation

### Batch 1 — Foundation
- Initial FastAPI platform API
- Health and readiness endpoints
- Platform metadata endpoint
- Automated tests

### Batch 2 — Containerization and Delivery
- Non-root Docker image
- Docker health check
- Hardened Docker Compose configuration
- GitHub Actions CI workflow
- Automated test and formatting gates
- Dependency, secret and filesystem security scans
- GHCR publishing gated by passing jobs
- SBOM and build provenance generation

## Local Development

```bash
make install
make check
make audit
make run
```

## Container Development

```bash
make docker-build
make docker-smoke
```

The container smoke-test endpoint is:
http://127.0.0.1:18100/health

## API Documentation

http://127.0.0.1:8000/docs

## Demonstration Workloads

1. APEX MLOps
2. NEXUS AI

## Architecture Direction

GitHub -> GitHub Actions -> Security Gates -> GHCR
-> Argo CD -> Kubernetes -> Observability

## Development Model

The initial environment is local-first using Docker and kind.
Cloud deployment is a future extension.

No production cloud deployment is claimed.

## Engineering Principles

- Secure by default
- Least privilege
- Reproducible builds
- Infrastructure as Code
- GitOps and auditable changes
- Automated quality gates
- Observable systems
- Tested recovery procedures
- Documentation as part of delivery
