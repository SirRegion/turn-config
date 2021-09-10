include ../../Makefile.pwsh

PROD_IMAGE_REF := complianceBaseContainerRegistry.azurecr.io/infrastructure/mdctec-maintenance:latest

build:
	$(MAKE) -C ../../scripts/powershell-modules .tmp
	cd ../..; docker-compose build mdctec-maintenance

push: build
	docker tag  infrastructure/mdctec-maintenance:latest  $(PROD_IMAGE_REF)
	docker push $(PROD_IMAGE_REF)
