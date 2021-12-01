include .make/configure-pwsh.mk

all: meta artifacts

artifacts:
	$(MAKE) -C scripts/powershell-modules/ artifacts

meta:
	$(MAKE) -C scripts/powershell-modules/MdctecMaintenanceMenu/meta -B

release:
	$(MAKE) -C scripts/powershell-modules/ artifacts
	$(MAKE) -C docker/mdctec-maintenance build

push:
	$(MAKE) -C docker/mdctec-maintenance push

clean:
	$(MAKE) -C scripts/powershell-modules/ clean
