SHELL := /bin/bash


KIND_CLUSTER := sandbox-cluster
SANDBOX_API_IMAGE := sandbox-api-image
WELCOME_API_IMAGE := welcome-api-image


docker-build-sandbox:
	docker build -t sandbox-api-image -f SandboxApi/Dockerfile . 