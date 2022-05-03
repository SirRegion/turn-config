

Param
(
    [Parameter(
            Mandatory=$true,
            HelpMessage="Enter the desired release version (eg localhost or ip adress).")
    ]
    [string]
    $CB_DOMAIN
)


. "${Env:MMM_HOME}/scripts/configure/set.ps1" "CB_DOMAIN" "${CB_DOMAIN}"
