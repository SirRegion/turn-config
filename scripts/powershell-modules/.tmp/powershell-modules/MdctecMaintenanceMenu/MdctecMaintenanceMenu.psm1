Import-Module MdctecMaintenanceMenu\support\show-menu -DisableNameChecking


Function MdctecMaintenanceMenu {
    [CmdLetBinding()]
    param()

    Write-Host " Welcome to the MDCTec Maintenance Menu (alias: MMM)! " -BackgroundColor White -ForegroundColor Black
    "Version: $(Get-Content $PSScriptRoot\.meta\version)"
    "Last modified: $(Get-Content $PSScriptRoot\.meta\timestamp)"
    ""

    $selection = Show-Menu -Items @(
        '[1] Install Docker Service',
        '[2] Setup Docker Environment',
        '[3] Install ComplianceBase with Docker',
        '[Optional] Reset this machine and start from scratch'
    )

    switch ($selection)
    {
        '1' {
            invoke-expression -Command "$PSScriptRoot\menu\01_install_docker.ws2019.ps1"
        } '2' {
            invoke-expression -Command "$PSScriptRoot\menu\02_setup_docker_environment.ws2019.ps1"
        } '3' {
            invoke-expression -Command "$PSScriptRoot\menu\03_setup_cb-app.ws2019.ps1"
        } '4' {
            invoke-expression -Command "$PSScriptRoot\menu\04_reset.ws2019.ps1"
        } 'q' {
            return
        }
    }
}
New-Alias -Name MMM -Value MdctecMaintenanceMenu

Export-ModuleMember -Function MdctecMaintenanceMenu -Alias MMM
