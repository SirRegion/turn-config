include ../../../Makefile.pwsh

.PHONY: .meta/timestamp

artifacts: MdctecMaintenanceMenu.zip

clean:
	-Remove-Item MdctecMaintenanceMenu.zip
	-Remove-Item .meta/timestamp

install: MdctecMaintenanceMenu.zip
	. ./install.ps1






MdctecMaintenanceMenu.zip: .meta/timestamp .meta/*
	Get-ChildItem -Exclude $$(Get-Content ./exclude.lst ) -Force | Compress-Archive -Force -DestinationPath ./MdctecMaintenanceMenu.zip

.meta/timestamp:
	"$$(Get-Date -Format "dddd dd/MM/yyyy HH:mm K")" | Out-File .\.meta\timestamp -Force;



