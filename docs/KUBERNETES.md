# FORGE Kubernetes Platform — Batch 3

## Runtime

- Local cluster: kind
- Cluster name: forge-local
- Kubernetes node image: v1.36.4
- CNI and NetworkPolicy enforcement: Calico v3.33.0
- Package manager: Helm
- One control-plane node, sized for a 4 GB Docker Desktop allocation

The project kubeconfig is stored under `.kube/config`.
The user's default Kubernetes context is not used.

## Namespaces

| Namespace | Purpose |
|---|---|
| forge-system | FORGE platform API |
| development | APEX MLOps demonstration workload |
| staging | Reserved deployment environment |

## APEX Workload

APEX MLOps 0.3.0 is built from its public source repository at commit:

`424c5e7d0a86869e0ff1e0dd1854f3765fe33c34`

Its Dockerfile trains a demonstration model from synthetic data.
The container listens on port 8000.

- Liveness: `/health/live`
- Readiness: `/health/ready`
- Model metadata: `/model/info`
- Inference: `/predict`

Production mode uses an API key stored as a Kubernetes Secret.
The key is not committed to Git.

The model artifacts are copied into an emptyDir volume at pod initialization.
Runtime drift and performance reports are ephemeral in this local demo.

## Security

- Restricted Pod Security Admission in application namespaces
- Non-root UID 10001
- Read-only root filesystems
- Dropped Linux capabilities
- No service-account token mounted into application pods
- CPU and memory requests/limits
- ResourceQuota and LimitRange
- Calico-enforced default-deny ingress/egress
- DNS egress only, same-namespace traffic, and explicitly allowed FORGE API traffic
- Namespaced RBAC for `forge-operator`
- The operator role cannot read Kubernetes Secrets

## Access

FORGE API:
`kubectl --kubeconfig .kube/config -n forge-system port-forward svc/forge-api 18080:8000`

APEX API:
`kubectl --kubeconfig .kube/config -n development port-forward svc/apex-api 18081:8000`

The local APEX API key is stored in `.kube/apex-api-key`.

## Cleanup

To remove only this local cluster:

`kind delete cluster --name forge-local`

This does not delete other Docker containers or Kubernetes projects.
