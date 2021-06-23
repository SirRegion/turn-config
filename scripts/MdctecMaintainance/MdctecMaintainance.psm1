Import-Module MdctecMaintainance\support\show-menu -DisableNameChecking

Function Menu {
    Write-Host " Welcome to the MDCTec Maintainance Menu! " -BackgroundColor White -ForegroundColor Black

    ""

    $selection = Show-Menu -Items @(
        'Install Docker Service',
        'Setup Docker Environment',
        'Install and Launch complianceBase app on this machine',
        'Reset this machine and start from scratch'
    )

    ""

    switch ($selection)
    {
        '1' {
            invoke-expression -Command "$PSScriptRoot\install_docker.windows.ps1"
        } '2' {
            invoke-expression -Command "$PSScriptRoot\setup_docker.windows.ps1"
        } '3' {
            invoke-expression -Command "$PSScriptRoot\launch_cb-app.windows.ps1"
        } '4'{
            invoke-expression -Command "$PSScriptRoot\reset.windows.ps1"
        } 'q' {
            return
        }
    }
}

Export-ModuleMember -Function Menu
