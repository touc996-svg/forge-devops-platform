# FORGE Security Strategy

## Implemented in the Initial Delivery Pipeline

- Non-root container execution
- Read-only container root filesystem
- Linux capability dropping
- No-new-privileges protection
- Container health checks
- CPU and memory constraints
- Gitleaks secret scanning
- Trivy filesystem scanning
- pip-audit dependency vulnerability checks
- Least-privilege GitHub workflow permissions
- GHCR publishing gated by quality and security jobs
- SBOM and build provenance generation

## Planned Security Extensions

- Backstage user authentication
- Platform API authorization
- Kubernetes RBAC
- Kubernetes NetworkPolicies
- Kyverno admission policies
- SOPS or External Secrets
- Cosign image signing and verification
- Runtime security monitoring
- Security audit event history

## Security Principle

A workflow must not publish a container image if required quality
or security gates fail.

Self-service platform actions must be authenticated, authorized,
validated, and auditable.
