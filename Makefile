include .make/configure-pwsh.mk

all: meta artifacts

artifacts:
	$(MAKE) -C scripts/powershell-modules/ artifacts

meta:
	$(MAKE) -C scripts/powershell-modules/MdctecMaintenanceMenu/meta -B


clean:
	$(MAKE) -C scripts/powershell-modules/ clean

