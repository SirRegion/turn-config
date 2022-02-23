include ../.make/configure-pwsh.mk

.PHONY: push push-stage push-prod push-all
###############################################

all: artifacts

clean:
	-Remove-Item powershell-modules.zip
	-Remove-Item powershell-modules.zip.files

setup:
	./setup.ps1

release: meta powershell-modules.zip.files

build: build-docker

build-docker: powershell-modules.zip.files
	$(MAKE) -C .docker/ build

push: push-all

push-stage push-prod push-all:
	$(MAKE) -C .docker $@

zip: powershell-modules.zip

###############################################

meta:
	$(MAKE) -C MdctecMaintenanceMenu/meta -B

artifacts: powershell-modules.zip

powershell-modules.zip: powershell-modules.zip.files
	Get-ChildItem $@.files -Force | Compress-Archive -Force -DestinationPath ./$@

ZIP_DEPS:=$(call rfindx, MdctecMaintenanceMenu,$(file < MdctecMaintenanceMenu/exclude.lst)) setup.ps1 README.txt

powershell-modules.zip.files: $(ZIP_DEPS)
	@# Listing all Prerequisites:
	@"$^" -Split ' '
	-Remove-Item -ErrorAction:Ignore -Recurse -Force $@
	Copy-Item -Recurse MdctecMaintenanceMenu -Exclude $$(Get-Content ./MdctecMaintenanceMenu/exclude.lst ) $@/MdctecMaintenanceMenu/
	Copy-Item ./setup.ps1,README.txt $@

MdctecMaintenanceMenu/meta:
	$(MAKE) -C $@





