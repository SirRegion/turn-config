include ../../Makefile.pwsh
.PHONY: powershell-modules.zip

artifacts: powershell-modules.zip

powershell-modules.zip:
	$(MAKE) -C MdctecMaintenanceMenu/ meta
	-Remove-Item -ea:Ignore -Recurse -Force .tmp
	Copy-Item -Recurse MdctecMaintenanceMenu -Exclude $$(Get-Content ./MdctecMaintenanceMenu/exclude.lst ) .tmp/MdctecMaintenanceMenu/
	Copy-Item ./setup.ps1 .tmp/
	Get-ChildItem .tmp -Force | Compress-Archive -Force -DestinationPath ./powershell-modules.zip

powershell-modules.exe:
	$(MAKE) -C MdctecMaintenanceMenu/ meta
	-@Remove-Item -ea:Ignore MdctecMaintenanceMenu.exe

	7z a -sfx $@ $$(Get-ChildItem -Exclude $$(Get-Content ./exclude.lst ) -Force)

setup:
	./setup.ps1

clean:
	-Remove-Item MdctecMaintenanceMenu.zip
