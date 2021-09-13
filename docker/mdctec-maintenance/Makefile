include ../../.make/configure-pwsh.mk

IMAGE_NAME := infrastructure/mdctec-maintenance
PROD_IMAGE_REF := $(PROD_IMAGE_REGISTRY)/$(IMAGE_NAME):latest

build:
	$(MAKE) -C ../../scripts/powershell-modules powershell-modules.zip.tmp
	docker build -f ./Dockerfile -t $(IMAGE_NAME):latest ../..
	$$null > $@

push: build
	docker tag  $(IMAGE_NAME):latest $(PROD_IMAGE_REF)
	docker push $(PROD_IMAGE_REF)

pull:
	docker pull $(PROD_IMAGE_REF)
