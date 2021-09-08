include Makefile.pwsh

artifacts:
	$(MAKE) -C scripts/powershell-modules/ artifacts

clean:
	$(MAKE) -C scripts/powershell-modules/ clean

devcontainer:
	docker-compose build devcontainer

devcontainer/shell:
	docker run -it --rm -v "$${PWD}:/workspace" infrastructure/devcontainer /bin/bash
