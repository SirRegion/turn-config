include ../../.make/configure-pwsh.mk

.PHONY: push push-stage push-prod push-all

DOCKER_IMAGE_NAME_LEGACY := infrastructure/mdctec-maintenance
DOCKER_IMAGE_NAME := internal/mdctec-maintenance
DOCKER_IMAGE_REF := $(DOCKER_IMAGE_NAME):latest
DOCKER_REGISTRY ?= := ${MTEC_STAGE_REGISTRY}

.DEFAULT_GOAL := build

build:
	docker build -f ./Dockerfile -t ${DOCKER_IMAGE_NAME}:latest ../

push-all:
	$(MAKE) push-stage
	$(MAKE) push-prod

push-prod: DOCKER_REGISTRY=${MTEC_PROD_REGISTRY}
push-stage: DOCKER_REGISTRY=${MTEC_STAGE_REGISTRY}
push push-stage push-prod:
	docker tag  ${DOCKER_IMAGE_REF} ${DOCKER_REGISTRY}/${DOCKER_IMAGE_REF}
	docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE_REF}
	docker tag  ${DOCKER_IMAGE_REF} ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME_LEGACY}:latest
	docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME_LEGACY}:latest
run:
	docker run ${DOCKER_IMAGE_REF} --name mdctec-maintenance

shell: run
	docker exec -it mdctec-maintenance powershell

pull:
	docker pull $(PROD_IMAGE_REF)

