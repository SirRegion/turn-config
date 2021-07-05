Import-Module MdctecMaintenance\support\show-menu -DisableNameChecking

Function Menu {
    Write-Host " Welcome to the MDCTec Maintenance Menu! " -BackgroundColor White -ForegroundColor Black

    ""

    $selection = Show-Menu -Items @(
        'Install Docker Service',
        'Setup Docker Environment',
        'Install ComplianceBase with Docker',
        'Reset this machine and start from scratch'
    )

    ""

    switch ($selection)
    {
        '1' {
            invoke-expression -Command "$PSScriptRoot\install_docker.ws2019.ps1"
        } '2' {
            invoke-expression -Command "$PSScriptRoot\setup_docker_environment.ws2019.ps1"
        } '3' {
            invoke-expression -Command "$PSScriptRoot\setup_cb-app.ws2019.ps1"
        } '4' {
            invoke-expression -Command "$PSScriptRoot\reset.ws2019.ps1"
        } 'q' {
            return
        }
    }
}

Export-ModuleMember -Function Menu
