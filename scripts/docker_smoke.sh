#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

cleanup() {
    docker compose down --remove-orphans
}

trap cleanup EXIT

echo "===== STARTING FORGE CONTAINER ====="
docker compose up --build -d

CID="$(docker compose ps -q forge-api)"

if [ -z "$CID" ]; then
    echo "ERROR: Container ID not found."
    docker compose logs
    exit 1
fi

echo ""
echo "===== WAITING FOR DOCKER HEALTHCHECK ====="

HEALTH="starting"

for attempt in $(seq 1 30); do
    HEALTH="$(docker inspect \
        --format '{{.State.Health.Status}}' "$CID" 2>/dev/null || echo missing)"

    echo "Attempt $attempt: Docker health = $HEALTH"

    if [ "$HEALTH" = "healthy" ]; then
        break
    fi

    if [ "$HEALTH" = "unhealthy" ] || [ "$HEALTH" = "missing" ]; then
        break
    fi

    sleep 2
done

if [ "$HEALTH" != "healthy" ]; then
    echo "ERROR: Docker healthcheck did not pass."
    docker inspect "$CID" --format '{{json .State.Health}}'
    docker compose logs
    exit 1
fi

echo ""
echo "===== VERIFYING NON-ROOT USER ====="

USER_ID="$(docker inspect --format '{{.Config.User}}' "$CID")"

echo "Container user: $USER_ID"

if [ "$USER_ID" != "10001:10001" ]; then
    echo "ERROR: Container is not running with expected non-root UID."
    exit 1
fi

echo ""
echo "===== VERIFYING API ENDPOINTS ====="

curl --fail --silent --show-error \
    http://127.0.0.1:18100/health

echo ""
curl --fail --silent --show-error \
    http://127.0.0.1:18100/ready

echo ""
echo "===== VERIFYING DOCKER HEALTH ====="
echo "Docker health: $HEALTH"
echo "Container user: $USER_ID"

echo ""
echo "FORGE DOCKER SMOKE TEST: PASSED"
