Import-Module MdctecMaintenanceMenu\support\deprecated\interactive-steps.psm1 -DisableNameChecking

$steps = @(
    [pscustomobject]@{
        Label = "Install the Docker-Microsoft PackageManagement Provider"
        Script     = 'Install-Module -Name DockerMsftProvider -Repository PSGallery -Force'
    }
    [pscustomobject]@{
        Label = "Install the Docker Package"
        Script     = 'Install-Package docker -ProviderName DockerMsftProvider -Force -RequiredVersion 20.10.6'
    }
    [pscustomobject]@{
        Label = "Restart the Machine"
        Script     = 'Restart-Computer -Force'
    }
)

Interactive-Steps $steps -TaskName "Setup Docker Environment"
