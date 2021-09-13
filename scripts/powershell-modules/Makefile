include ../../.make/configure-pwsh.mk

all: artifacts

clean:
	-Remove-Item powershell-modules.zip
	-Remove-Item powershell-modules.zip.tmp

setup:
	./setup.ps1

###############################################

artifacts: powershell-modules.zip

powershell-modules.zip: powershell-modules.zip.tmp
	Get-ChildItem $@.tmp -Force | Compress-Archive -Force -DestinationPath ./$@

ZIP_DEPS:=$(call rfindx, MdctecMaintenanceMenu,$(file < MdctecMaintenanceMenu/exclude.lst)) setup.ps1

powershell-modules.zip.tmp: $(ZIP_DEPS)
	@# Listing all Prerequisites:
	@#"$^" -Split ' '
	-Remove-Item -ErrorAction:Ignore -Recurse -Force $@
	Copy-Item -Recurse MdctecMaintenanceMenu -Exclude $$(Get-Content ./MdctecMaintenanceMenu/exclude.lst ) $@/MdctecMaintenanceMenu/
	Copy-Item ./setup.ps1 $@

MdctecMaintenanceMenu/meta:
	$(MAKE) -C $@

ls:
	"$(DEPS)" -Split ' '




