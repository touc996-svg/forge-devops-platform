from datetime import UTC, datetime

from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(
    title="FORGE Platform API",
    description="Internal Developer Platform and DevSecOps Automation",
    version="0.1.0",
)


class PlatformStatus(BaseModel):
    platform: str
    version: str
    status: str
    timestamp: datetime


@app.get("/health", tags=["Platform"])
def health() -> dict[str, str]:
    return {"status": "healthy", "service": "forge-platform-api"}


@app.get("/ready", tags=["Platform"])
def readiness() -> dict[str, str]:
    return {"status": "ready", "service": "forge-platform-api"}


@app.get("/api/v1/platform", response_model=PlatformStatus, tags=["Platform"])
def platform_status() -> PlatformStatus:
    return PlatformStatus(
        platform="FORGE",
        version=app.version,
        status="operational",
        timestamp=datetime.now(UTC),
    )
