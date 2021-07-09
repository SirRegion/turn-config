include Makefile.pwsh

artifacts:
	$(MAKE) -C scripts/powershell/MdctecMaintenance artifacts

clean:
	$(MAKE) -C scripts/powershell/MdctecMaintenance clean
