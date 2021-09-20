include ../../.make/configure-pwsh.mk

IMAGE_NAME := infrastructure/mdctec-maintenance
PROD_IMAGE_REF := $(PROD_IMAGE_REGISTRY)/$(IMAGE_NAME):latest

#.RECIPEPREFIX:=../../scripts/powershell-modules/
#include ../../scripts/powershell-modules/Makefile
.PHONY: ../../scripts/powershell-modules/powershell-modules.zip.files

build: ../../scripts/powershell-modules/powershell-modules.zip.files
	docker build -f ./Dockerfile -t $(IMAGE_NAME):latest ../..
	$$null > $@

#.RECIPEPREFIX:=./
push: build
	docker tag  $(IMAGE_NAME):latest $(PROD_IMAGE_REF)
	docker push $(PROD_IMAGE_REF)

pull:
	docker pull $(PROD_IMAGE_REF)

clean:
	-Remove-Item -ErrorAction:Ignore build

../../scripts/powershell-modules/powershell-modules.zip.files:
	$(MAKE) -C ../../scripts/powershell-modules powershell-modules.zip.files
