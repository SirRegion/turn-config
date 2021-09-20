define \n

endef

define rfind
$(addprefix $(strip $(1))/,$(shell Get-ChildItem -Recurse -Force -Name $(1) | ForEach-Object { "$$_" -Replace '\\','/'}) )
endef

define rfindx
$(addprefix $(strip $(1))/,$(shell cd $(1);Get-ChildItem -Recurse -Force -Name -Exclude $$(@($(patsubst %,'%';,$(2)))) | ForEach-Object { "$$_" -Replace '\\','/'}) )
endef

#define include-x
#$(1)/$(2):
#	$(MAKE) -C $(1) $(2)
#endef
