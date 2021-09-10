Import-Module MdctecMaintenanceMenu\support\show-menu -DisableNameChecking
Import-Module MdctecMaintenanceMenu\support\LoadMenuFromPath -DisableNameChecking

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

    $selection = Show-Menu -Items @(
        'Check for updates'
        'Install Docker Service',
        'Setup Docker Environment',
        'Install ComplianceBase with Docker',
        '[Optional] Reset and Cleanup'
    )

    switch ( $selection )
    {
        '1' {
            & "$PSScriptRoot\menu\Check for updates.ps1"
        }
        '2' {
            invoke-expression -Command "$PSScriptRoot\menu\01_install_docker.ws2019.ps1"
        } '3' {
            invoke-expression -Command "$PSScriptRoot\menu\02_setup_docker_environment.ws2019.ps1"
        } '4' {
            invoke-expression -Command "$PSScriptRoot\menu\03_setup_cb-app.ws2019.ps1"
        } '5' {
            LoadMenuFromPath $(Join-Path "$PSScriptRoot" ‘menu\Reset and Cleanup’ )
        } 'q' {
            return
        }
    }
}

New-Alias -Name MMM -Value MdctecMaintenanceMenu

Export-ModuleMember -Function MdctecMaintenanceMenu -Alias MMM
