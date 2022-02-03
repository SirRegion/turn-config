Function MdctecMaintenanceMenu2
{
    [CmdLetBinding()]
    param(
        [Alias('r')]
        [switch]
        $ResetState = $False
    )

    if ($ResetState)
    {
        Import-Module "$PSScriptRoot/lib/FancyMenu" -Force;
    }
    else
    {
        Import-Module "$PSScriptRoot/lib/FancyMenu";
    }
    FancyMenu "$PSScriptRoot" $ResetState
}

New-Alias -Name MMM2 -Value MdctecMaintenanceMenu2

Export-ModuleMember -Function MdctecMaintenanceMenu2 -Alias MMM2
