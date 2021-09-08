include ../../Makefile.pwsh
.PHONY: MdctecMaintenanceMenu.zip

artifacts: MdctecMaintenanceMenu.zip

MdctecMaintenanceMenu.zip:
	$(MAKE) -C MdctecMaintenanceMenu/ .meta
	Remove-Item -ea:Ignore -Recurse -Force .tmp
	Copy-Item -Recurse MdctecMaintenanceMenu -Exclude $$(Get-Content ./MdctecMaintenanceMenu/exclude.lst ) .tmp/powershell-modules/MdctecMaintenanceMenu/
	Copy-Item ./setup.ps1 .tmp/powershell-modules/
	Get-ChildItem .tmp -Force | Compress-Archive -Force -DestinationPath ./MdctecMaintenanceMenu.zip

MdctecMaintenanceMenu.exe:
	$(MAKE) -C MdctecMaintenanceMenu/ .meta
	-@Remove-Item -ea:Ignore MdctecMaintenanceMenu.exe

	7z a -sfx $@ $$(Get-ChildItem -Exclude $$(Get-Content ./exclude.lst ) -Force)

setup:
	./setup.ps1

clean:
	-Remove-Item MdctecMaintenanceMenu.zip
