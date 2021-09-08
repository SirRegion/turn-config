include Makefile.pwsh

artifacts:
	$(MAKE) -C scripts/powershell/MdctecMaintenanceMenu artifacts

clean:
	$(MAKE) -C scripts/powershell/MdctecMaintenanceMenu clean
