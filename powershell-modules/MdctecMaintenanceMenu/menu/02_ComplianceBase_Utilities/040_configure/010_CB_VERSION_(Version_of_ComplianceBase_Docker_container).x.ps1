
Param
(
    [Parameter(
            Mandatory=$true,
            HelpMessage="Enter the desired release version (eg 0.0.1-rc4).")
    ]
    [string]
    $CB_VERSION
)

. "${Env:MMM_HOME}/scripts/configure/set.ps1" "CB_VERSION" "${CB_VERSION}"
