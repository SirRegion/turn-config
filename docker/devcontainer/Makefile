include ../../.make/configure-pwsh.mk

build:
	docker-compose build devcontainer

shell:
	docker run -it --rm -v "$${PWD}:/workspace" infrastructure/devcontainer /bin/bash
