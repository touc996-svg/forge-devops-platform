# FORGE CI/CD and Container Delivery

## Container Architecture

The FORGE API is packaged in a Python 3.14 slim container.

Security defaults:
- Non-root UID 10001
- Minimal runtime dependencies
- Read-only root filesystem in Docker Compose
- Dropped Linux capabilities
- No-new-privileges security option
- PID, memory and CPU constraints
- Docker health check

## CI Pipeline

The GitHub Actions workflow runs:

1. Python environment setup
2. Dependency installation
3. Ruff linting
4. Ruff formatting validation
5. Pytest
6. Docker image build
7. Container smoke test

## Security Gates

The security job runs:

- pip-audit for dependency vulnerabilities
- Gitleaks for exposed secrets
- Trivy for filesystem vulnerabilities,
  misconfigurations and secrets

Critical and high Trivy findings fail the job.

## Image Publishing

The GHCR publishing job requires both quality and security jobs to pass.

Images are tagged with:
- Main branch
- Commit SHA
- Latest default-branch tag

The build also produces:
- SBOM
- Build provenance

## Local Commands

```bash
make install
make check
make audit
make docker-build
make docker-smoke
```

Docker Compose exposes the API at:
http://127.0.0.1:18100

## Current Boundary

The workflow is authored locally but GitHub Actions and GHCR publishing
will not run until this repository is pushed to GitHub.

The initial registry build targets linux/amd64.

## Verified GitHub Actions Execution

First GitHub Actions validation:
- Run ID: 42617740304
- Event: workflow_dispatch
- Branch: main
- Security Gates: passed
- Code Quality and Container Tests: passed

Verified security controls:
- Python dependency audit
- Gitleaks
- Trivy filesystem scan

Verified quality controls:
- Ruff lint and formatting
- Pytest
- Docker image build
- Container smoke test

The GHCR publish job was skipped in this manual run because
publishing is intentionally restricted to pushes on the main branch.

The next main-branch push will validate the publishing stage.
