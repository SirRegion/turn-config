# directory of the current file:
DIR_NAME := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

current_file_root := $(lastword $(MAKEFILE_LIST))

### Configure Powershell
ifeq ($(OS),Windows_NT)
# When running on windows, the executable path is different
SHELL := pwsh.exe

else
# On all other systems, assume linux executable name
SHELL := pwsh

endif
.SHELLFLAGS := -Command


include $(DIR_NAME)/utils.mk
include $(dir $(DIR_NAME))/variables.mk
