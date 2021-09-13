Import-Module MdctecMaintenanceMenu\support\show-menu -DisableNameChecking
Import-Module MdctecMaintenanceMenu\support\LoadMenuFromPath -DisableNameChecking

$OutputEncoding = [System.Text.Encoding]::UTF8

Function MdctecMaintenanceMenu {
    [CmdLetBinding()]
    param()

    Write-Host " Welcome to the MDCTec Maintenance Menu (alias: MMM)! " -BackgroundColor White -ForegroundColor Black
    if (Test-Path "$PSScriptRoot\meta\version"){
        "Version: $(Get-Content $PSScriptRoot\meta\version)"
    }

    if (Test-Path "$PSScriptRoot\meta\timestamp")
    {
        "Last modified: $( Get-Content $PSScriptRoot\meta\timestamp )"
    }
    ""

    LoadMenuFromPath $(Join-Path "$PSScriptRoot" "menu" )
}

New-Alias -Name MMM -Value MdctecMaintenanceMenu

Export-ModuleMember -Function MdctecMaintenanceMenu -Alias MMM
