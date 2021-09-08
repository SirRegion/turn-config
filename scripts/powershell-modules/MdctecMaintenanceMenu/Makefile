include ../../../Makefile.pwsh

.PHONY: .meta/timestamp


clean:
	-Remove-Item .meta/timestamp

.meta: .meta/timestamp

.meta/timestamp:
	"$$(Get-Date -Format "dddd dd/MM/yyyy HH:mm K")" | Out-File .\.meta\timestamp -Force;



