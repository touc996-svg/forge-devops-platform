from app.main import app
from fastapi.testclient import TestClient

client = TestClient(app)


def test_health():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["status"] == "healthy"


def test_readiness():
    response = client.get("/ready")
    assert response.status_code == 200
    assert response.json()["status"] == "ready"


def test_platform_metadata():
    response = client.get("/api/v1/platform")
    assert response.status_code == 200

    data = response.json()
    assert data["platform"] == "FORGE"
    assert data["version"] == "0.1.0"
    assert data["status"] == "operational"
