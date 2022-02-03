include ../../.make/configure-pwsh.mk

IMAGE_NAME := infrastructure/mdctec-maintenance
PROD_IMAGE_REF := $(PROD_IMAGE_REGISTRY)/$(IMAGE_NAME):latest

.DEFAULT_GOAL := build


build:
	docker build -f ./Dockerfile -t $(IMAGE_NAME):latest ../

push: build
	docker tag  $(IMAGE_NAME):latest $(PROD_IMAGE_REF)
	docker push $(PROD_IMAGE_REF)

run:
	docker run ${IMAGE_NAME} --name mdctec-maintenance

shell: run
	docker exec -it mdctec-maintenance powershell

pull:
	docker pull $(PROD_IMAGE_REF)

