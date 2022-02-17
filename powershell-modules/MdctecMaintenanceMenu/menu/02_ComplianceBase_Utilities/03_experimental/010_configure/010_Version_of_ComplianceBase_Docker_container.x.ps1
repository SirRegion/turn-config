## TODO: allow to choose from avalable versions
#. "$Env:MMM_HOME/MdctecMaintenanceMenu/assets/environment/docker/default.env.ps1"


Param
(
    [Parameter(
            Mandatory=$true,
            HelpMessage="Enter the desired release version (eg 0.0.1-rc4).")
    ]
    [string]
    $CB_VERSION
)


. "${Env:MMM_HOME}/MdctecMaintenanceMenu/scripts/configure/set.ps1" "CB_VERSION" "${CB_VERSION}"
