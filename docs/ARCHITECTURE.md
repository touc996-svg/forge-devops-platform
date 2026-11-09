# FORGE Architecture

## Mission

Provide a secure, auditable self-service platform for creating,
deploying, operating, and recovering software services.

## Platform Layers

1. Developer experience: Backstage, software catalog, golden paths.
2. Platform API: FastAPI, automation, authorization, audit events.
3. Software delivery: GitHub Actions, tests, security, image builds.
4. Registry: GHCR, immutable artifacts.
5. Infrastructure: Terraform, Docker, Kubernetes, Helm.
6. GitOps: Argo CD and environment promotion.
7. Security: RBAC, Trivy, Gitleaks, Kyverno, SBOM, signing.
8. Observability: OpenTelemetry, Prometheus, Grafana, Loki, Tempo.
9. Reliability: SLOs, alerting, backup, restore, incident response.

## Initial Runtime

The initial platform is local-first using Docker and kind.
APEX MLOps is the first intended demonstration workload.
NEXUS AI is a later, more complex workload.

## Security Boundary

Self-service actions must be authenticated, authorized, validated,
auditable, and restricted by policy.

This document describes the target architecture. Components not yet
implemented must not be represented as completed capabilities.
