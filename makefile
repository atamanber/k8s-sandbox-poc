SHELL := /bin/bash

KIND_CLUSTER := sandbox-cluster
SANDBOX_API_IMAGE := sandbox-api-image
WELCOME_API_IMAGE := welcome-api-image

docker-build-sandbox:
	docker build -t ${SANDBOX_API_IMAGE} -f SandboxApi/Dockerfile ./SandboxApi

docker-build-welcome:
	docker build -t ${WELCOME_API_IMAGE} -f WelcomeApi/Dockerfile ./WelcomeApi

# Upgrade to latest Kind: brew upgrade kind
# For full Kind v0.16 release notes: https://github.com/kubernetes-sigs/kind/releases/tag/v0.16.0
# The image used below was copied by the above link and supports both amd64 and arm64.

kind-up:
	kind create cluster \
		--image kindest/node:v1.25.0@sha256:428aaa17ec82ccde0131cb2d1ca6547d13cf5fdabcc0bbecf749baa935387cbf \
		--name $(KIND_CLUSTER) \
		--config k8s/kind/kind-config.yaml
	kubectl config set-context --current

kind-down:
	kind delete cluster --name $(KIND_CLUSTER)

kind-all:
	make kind-up
	make kind-load-sandbox-api
	make kind-load-welcome-api
	make kind-apply-service-account
	make kind-apply-sandbox-api
	make kind-apply-sandbox-ingress
	make kind-apply-nginx

kind-load-sandbox-api:
	kind load docker-image ${SANDBOX_API_IMAGE} --name $(KIND_CLUSTER)

kind-load-welcome-api:
	kind load docker-image ${WELCOME_API_IMAGE} --name $(KIND_CLUSTER)

kind-apply-service-account:
	kubectl apply -f k8s/sandbox-api/sandbox-service-account.yaml

kind-apply-sandbox-api:
	kubectl apply -f k8s/sandbox-api/sandbox-api.yaml
 
kind-apply-sandbox-ingress:
	kubectl apply -f k8s/sandbox-api/sandbox-api-ingress.yaml

kind-apply-nginx:
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml