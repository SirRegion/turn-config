Import-Module MdctecMaintenanceMenu\support\interactive-steps.psm1 -DisableNameChecking

$steps = @(
    [pscustomobject]@{
        Description = "Install the Docker-Microsoft PackageManagement Provider"
        Command     = 'Install-Module -Name DockerMsftProvider -Repository PSGallery -Force'
    }
    [pscustomobject]@{
        Description = "Install the Docker Package"
        Command     = 'Install-Package docker -ProviderName DockerMsftProvider -Force -RequiredVersion 20.10.6'
    }
    [pscustomobject]@{
        Description = "Restart the Machine"
        Command     = 'Restart-Computer -Force'
    }
)

Interactive-Steps $steps -TaskName "Setup Docker Environment"
