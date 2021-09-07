include ../../../Makefile.pwsh

artifacts: MdctecMaintenance.zip

clean:
	-Remove-Item MdctecMaintenance.zip
	-Remove-Item -Recurse .meta

MdctecMaintenance.zip: .meta
	Get-ChildItem -Exclude $$(Get-Content ./exclude.lst ) -Force| Compress-Archive -Force -DestinationPath ./MdctecMaintenance.zip

.meta:
	New-Item -ItemType Directory -Force -Path .\.meta | Out-Null;
	"$$(git rev-parse --short HEAD)" | Out-File .\.meta\version -Force;
	"$$(Get-Date -Format "dddd dd/MM/yyyy HH:mm K")" | Out-File .\.meta\timestamp -Force;



