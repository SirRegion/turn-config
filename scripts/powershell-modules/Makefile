include ../../Makefile.pwsh
.PHONY: .tmp powershell-modules.zip

artifacts: powershell-modules.zip

.tmp:
	$(MAKE) -C MdctecMaintenanceMenu/ meta
	-Remove-Item -ea:Ignore -Recurse -Force .tmp
	Copy-Item -Recurse MdctecMaintenanceMenu -Exclude $$(Get-Content ./MdctecMaintenanceMenu/exclude.lst ) .tmp/MdctecMaintenanceMenu/
	Copy-Item ./setup.ps1 .tmp/

powershell-modules.zip: .tmp

	Get-ChildItem .tmp -Force | Compress-Archive -Force -DestinationPath ./powershell-modules.zip

setup:
	./setup.ps1

clean:
	-Remove-Item MdctecMaintenanceMenu.zip
