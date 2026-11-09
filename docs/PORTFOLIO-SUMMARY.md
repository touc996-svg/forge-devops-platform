# FORGE Portfolio Summary

## Project title

**FORGE — Enterprise Internal Developer Platform & Automated DevSecOps Delivery System**

## Project description

FORGE is a portfolio project demonstrating platform engineering and DevSecOps practices through an automated container delivery pipeline and a local Kubernetes environment. It combines GitHub Actions quality and security gates, container publishing to GHCR, reusable Helm deployments, Calico network segmentation, Kubernetes resource controls, and scoped operator RBAC.

The platform deploys and validates an integrated APEX MLOps inference API with API-key authentication and namespace-level traffic boundaries.

## Technical skills demonstrated

- Platform Engineering
- Kubernetes and kind
- Helm chart design and application deployment
- Docker and container hardening
- GitHub Actions CI/CD
- GitHub Container Registry
- DevSecOps security scanning
- SBOM and build provenance generation
- Calico Kubernetes NetworkPolicies
- Kubernetes namespaces, quotas, and LimitRanges
- Kubernetes RBAC and least privilege
- FastAPI deployment
- MLOps model serving and API authentication
- Operational testing and technical documentation

## CV-ready project entry

**FORGE — Enterprise Internal Developer Platform & Automated DevSecOps Delivery System**

- Built a GitHub Actions CI/CD pipeline integrating code-quality checks, automated tests, container validation, dependency auditing, secret scanning, and Trivy filesystem scanning.
- Implemented container publishing to GitHub Container Registry with SBOM and build provenance generation.
- Deployed a reusable Helm-based platform to a local kind Kubernetes cluster, integrating FORGE and APEX MLOps services.
- Implemented Calico default-deny network segmentation and validated approved and blocked traffic paths across platform, development, and staging namespaces.
- Configured scoped Kubernetes RBAC for a platform operator, verifying deployment-management permissions while denying Secrets access.
- Validated authenticated APEX inference, health checks, model artifact loading, and Kubernetes workload readiness.

## Interview explanation

"I built FORGE to demonstrate how platform engineering and DevSecOps controls work together. The CI pipeline checks code quality, runs tests, scans dependencies and secrets, scans the filesystem, and publishes a container image with an SBOM and provenance. I deployed the services into a local Kubernetes cluster using a reusable Helm chart. I used Calico to enforce namespace-level network policies and Kubernetes RBAC to give the platform operator only the permissions it needs. I validated the implementation with prediction requests, allowed and denied network tests, and RBAC permission checks."

## Honest scope statement

The validated environment is a local, single-node Kubernetes cluster. The project does not claim a production AWS/Azure deployment, public ingress, multi-node high availability, or model performance on real customer data. APEX training uses synthetic data.
