PYTHON := .venv/bin/python
PIP := .venv/bin/pip
RUFF := .venv/bin/ruff

.PHONY: help install test lint format format-check check audit run
.PHONY: docker-build docker-up docker-smoke docker-down docker-logs

help:
	@echo "FORGE Engineering Commands"
	@echo ""
	@echo "make install       Install development dependencies"
	@echo "make check         Run lint, formatting and tests"
	@echo "make audit         Audit Python dependencies"
	@echo "make run           Run local FastAPI service"
	@echo "make docker-build  Build production container"
	@echo "make docker-up     Start Docker Compose"
	@echo "make docker-smoke  Start and test container"
	@echo "make docker-down   Stop Docker Compose"
	@echo "make docker-logs   View container logs"

install:
	python3 -m venv .venv
	$(PYTHON) -m pip install --upgrade pip
	$(PYTHON) -m pip install -r requirements.txt -r requirements-dev.txt

test:
	PYTHONPATH=portal/forge-api $(PYTHON) -m pytest portal/forge-api/tests -v

lint:
	$(RUFF) check portal/forge-api

format:
	$(RUFF) format portal/forge-api

format-check:
	$(RUFF) format --check portal/forge-api

check: lint format-check test

audit:
	$(PYTHON) -m pip_audit -r requirements.txt
	$(PYTHON) -m pip_audit -r requirements-dev.txt

run:
	PYTHONPATH=portal/forge-api $(PYTHON) -m uvicorn app.main:app --reload --host 127.0.0.1 --port 8000

docker-build:
	docker build --pull -t forge-platform-api:local .

docker-up:
	docker compose up --build -d

docker-smoke:
	bash scripts/docker_smoke.sh

docker-down:
	docker compose down

docker-logs:
	docker compose logs -f
