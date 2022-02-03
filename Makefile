include .make/configure-pwsh.mk

all: artifacts

artifacts:
	$(MAKE) -C powershell-modules/ artifacts

clean:
	$(MAKE) -C powershell-modules/ clean
