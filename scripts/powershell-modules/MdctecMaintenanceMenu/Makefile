include ../../../Makefile.pwsh

.PHONY: .meta/timestamp


clean:
	-Remove-Item .meta/timestamp

.meta: .meta/timestamp

.meta/timestamp:
	[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId((Get-Date),'Central European Standard Time')|Out-File .\.meta\timestamp -Force;



