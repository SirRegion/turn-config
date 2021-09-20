Import-Module MdctecMaintenanceMenu\support\interactive-steps.psm1 -DisableNameChecking

"Checking current system environment..."

$v = $(docker -v)

if ($v -eq $null) {
    Write-Host "could not find any version of docker!" -ForegroundColor "red"
    Write-Host "Make sure that docker is installed and executable!" -ForegroundColor "red"
    return
} else {
    Write-Host "Docker version: $v" -ForegroundColor "cyan"
}

$steps = @(
    [pscustomobject]@{
        Description = 'Pull the Windows-Server Core base image. (This may take a quite some time)'
        Command = 'docker pull mcr.microsoft.com/windows/servercore:ltsc2019'
    },
    [pscustomobject]@{
        Description = 'Pull_the_latest_version_of_the_cb-app_container.'
        Command = 'docker pull complianceBaseContainerRegistry.azurecr.io/cb-app/stand-alone/windows:demo_2021.0.1'
    }
    [pscustomobject]@{
        Description = 'Stop_any_existing_instances'
        Command = 'docker rm -f cb-app'
    }
    [pscustomobject]@{
        Description = 'Launch_the_complianceBase_frontend_container'
        Command = 'docker run -d -p 80:80/udp 80:80/tcp --name cb-app --rm complianceBaseContainerRegistry.azurecr.io/cb-app/stand-alone/windows:demo_2021.0.1'
    }
)

Interactive-Steps $steps -TaskName "Install and Launch complianceBase app on this machine"
