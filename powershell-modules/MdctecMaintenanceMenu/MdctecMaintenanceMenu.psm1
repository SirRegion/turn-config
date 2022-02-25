$OutputEncoding = [System.Text.Encoding]::UTF8

Function MdctecMaintenanceMenu
{
    [CmdLetBinding()]
    param(
        [Alias('r')]
        [switch]
        $ResetState = $False
    )
    $RootPath = "$PSScriptRoot"

    Import-Module MdctecMaintenanceMenu/scripts/env/utils -DisableNameChecking;

    CoerceDefaults $RootPath

    if ($ResetState)
    {
        Import-Module MdctecMaintenanceMenu/support/FancyMenu -DisableNameChecking -Force;
    }
    else
    {
        Import-Module MdctecMaintenanceMenu/support/FancyMenu -DisableNameChecking;
    }

    FancyMenu "$RootPath" $ResetState
}

New-Alias -Name MMM -Value MdctecMaintenanceMenu

Export-ModuleMember -Function MdctecMaintenanceMenu -Alias MMM
