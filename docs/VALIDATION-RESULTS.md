# FORGE Validation Results

**Validation date:** November 9, 2026

This report records observed CI/CD and local Kubernetes validation results.

## 1. GitHub Actions CI/CD

The push-triggered workflow completed successfully:

[GitHub Actions run #42618094520](https://github.com/touc996-svg/forge-devops-platform/actions/runs/42618094520)

| Job | Result |
|---|---|
| Code Quality and Container Tests | Passed |
| DevSecOps Security Gates | Passed |
| Publish Secure Image to GHCR | Passed |

The workflow included Ruff, pytest, Docker build and smoke testing, pip-audit, Gitleaks, Trivy filesystem scanning, GHCR publishing, SBOM generation, and build provenance.

## 2. Kubernetes platform

| Component | Observed result |
|---|---|
| Cluster | kind `forge-local` |
| Kubernetes | v1.36.4 |
| Calico | v3.33.0 |
| Kubernetes node | Ready |
| FORGE API | 1/1 Ready |
| APEX API | 1/1 Ready |

Calico status resources reported `Available=True`.

## 3. APEX MLOps deployment

APEX MLOps 0.3.0 was deployed in the `development` namespace using the reusable Helm chart.

The init-container issue was resolved by removing an unnecessary `chmod` operation on the mounted model-artifacts volume. The init container subsequently completed successfully with exit code 0.

| Check | Result |
|---|---|
| Model artifacts readable | Passed |
| APEX pod | Running, 1/1 Ready |
| `/health/live` | HTTP 200 |
| `/health/ready` | HTTP 200 |
| `/model/info` without API key | HTTP 401 |
| `/model/info` with valid API key | HTTP 200 |
| Authenticated `/predict` | HTTP 200 |
| Unauthenticated `/predict` | HTTP 401 |

The prediction smoke test returned two valid prediction records. The response validator checked the binary class, probability range, and risk-band values.

## 4. Model evaluation context

The deployed model is a Random Forest churn classifier trained on synthetic data.

| Metric | Observed result |
|---|---:|
| Accuracy | 0.8594 |
| Precision | 0.7536 |
| Recall | 0.6500 |
| F1 | 0.6980 |
| Holdout ROC-AUC | 0.8696 |
| Cross-validation ROC-AUC mean | 0.8943 |

The training run used 1,600 synthetic rows: 1,280 training rows and 320 test rows.

These metrics describe the project's synthetic dataset only. They do not demonstrate model performance on real customer data.

The model registry was disabled in the validated deployment.

## 5. Calico NetworkPolicy tests

Temporary probe pods were created in the development and staging namespaces.

| Source | Destination | Expected | Observed |
|---|---|---|---|
| development | APEX API | Allowed | Allowed |
| development | FORGE API | Allowed | Allowed |
| staging | FORGE API | Allowed | Allowed |
| staging | APEX API | Blocked | Blocked |

The staging-to-APEX DNS lookup succeeded, while the TCP connection timed out as expected under the configured policy.

## 6. Kubernetes RBAC tests

Permissions were tested using `kubectl auth can-i` as the `forge-operator` service account identity.

| Permission | development | staging |
|---|---|---|
| Patch deployments | Yes | Yes |
| Read pods | Yes | Yes |
| Read services | Yes | Yes |
| Read events | Yes | Yes |
| Read Secrets | No | No |
| List Secrets | No | No |

All 12 RBAC assertions passed.

## 7. Final NetworkPolicy and RBAC results

| Test group | Passed |
|---|---:|
| Development probe readiness | 1 |
| Staging probe readiness | 1 |
| Network connectivity assertions | 4 |
| RBAC assertions | 12 |
| **Total** | **18** |

Observed final output:

```text
PASSED: 18
FAILED: 0

ALL NETWORK POLICY AND RBAC CHECKS PASSED.
```

The temporary probe pods were removed by the validation script's cleanup routine.

## 8. Scope and limitations

The evidence confirms the tested CI jobs, local workload readiness, APEX inference and authentication, selected Calico network paths, and the tested RBAC permissions.

The environment is a local single-node kind cluster. No production AWS/Azure deployment, public ingress, multi-node high availability, external penetration test, or real-world model accuracy is claimed.
