define \n

endef
define rfind
$(addprefix $(strip $(1))/,$(shell Get-ChildItem -Recurse -Force -Name $(1) | ForEach-Object { "$$_" -Replace '\\','/'}) )
endef


#$(addprefix $(strip $(1))/,$(shell cd $(1);Get-ChildItem -Recurse -Force -Name -Exclude $$(@($(patsubst %,'%';,$(2)))) | ForEach-Object { "$$_" -Replace '\\','/'}) )
define rfindx
$(addprefix $(strip $(1))/,$(shell cd $(1);Get-ChildItem -Recurse -Force -Name -Exclude $$(@($(patsubst %,'%';,$(2)))) | ForEach-Object { "$$_" -Replace '\\','/'}) )
endef
