include ../../.make/configure-pwsh.mk

.PHONY: push push-stage push-prod push-all


DOCKER_IMAGE_TAG := $(file < ../MdctecMaintenanceMenu/meta/version)
DOCKER_IMAGE_NAME := internal/mdctec-maintenance
DOCKER_IMAGE_REF := ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
DOCKER_REGISTRY ?= ${MTEC_DEV_REGISTRY}

.DEFAULT_GOAL := build

build:
	docker build -f ./Dockerfile -t ${DOCKER_IMAGE_REF} ../

push-all:
	$(MAKE) push-stage
	$(MAKE) push-prod


push-prod: DOCKER_REGISTRY=${MTEC_PROD_REGISTRY}
push-legacy: DOCKER_REGISTRY=${MTEC_PROD_REGISTRY}
push-stage: DOCKER_REGISTRY=${MTEC_DEV_REGISTRY}

push push-stage push-prod:
	$$PUBLIC_NAME='${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}'; docker tag ${DOCKER_IMAGE_REF} $${PUBLIC_NAME}; docker push $${PUBLIC_NAME}
	$$PUBLIC_NAME='${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:latest'; docker tag ${DOCKER_IMAGE_REF} $${PUBLIC_NAME}; docker push $${PUBLIC_NAME}

push-legacy:
	docker tag  ${DOCKER_IMAGE_REF} ${DOCKER_REGISTRY}/infrastructure/mdctec-maintenance:latest
	docker push ${DOCKER_REGISTRY}/infrastructure/mdctec-maintenance:latest

run:
	docker run ${DOCKER_IMAGE_REF} --name mdctec-maintenance

shell: run
	docker exec -it mdctec-maintenance powershell

pull:
	docker pull $(PROD_IMAGE_REF)

