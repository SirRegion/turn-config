Import-Module MdctecMaintenance\support\interactive-steps.psm1 -DisableNameChecking

"Checking current system environment..."

$v = $(docker -v)

if ($v -eq $null) {
    Write-Host "could not find any version of docker!" -ForegroundColor "red"
    Write-Host "Make sure that docker is installed and executable!" -ForegroundColor "red"
    return
} else {
    Write-Host $v -ForegroundColor "cyan"
}

$steps = @(
    [pscustomobject]@{
        Description = 'Pull the Windows-Server Core base image. (This may take a little longer)'
        Command = 'docker pull mcr.microsoft.com/windows/servercore:ltsc2019'
    },
    [pscustomobject]@{
        Description = 'Pull the latest version of the complianceBase application container.'
        Command = 'docker pull complianceBaseContainerRegistry.azurecr.io/cb-app/stand-alone/windows:demo_2021.0.1'
    }
    [pscustomobject]@{
        Description = 'Launch the complianceBase frontend'
        Command = 'docker run -p 80:80 --name cb-app_stand-alone complianceBaseContainerRegistry.azurecr.io/cb-app/stand-alone/windows:demo_2021.0.1'
    }
)

Interactive-Steps $steps -TaskName "Install and Launch complianceBase app on this machine"
