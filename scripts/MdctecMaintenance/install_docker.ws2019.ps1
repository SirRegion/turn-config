Import-Module MdctecMaintenance\support\interactive-steps.psm1 -DisableNameChecking

# Enable Hyper-V and Containers Windows Features
# (may require a manual reboot afterwards! Watch the console output to see if this is required)
#Enable-WindowsOptionalFeature -Online -FeatureName $("Microsoft-Hyper-V", "Containers") -All -NoRestart

$steps = @(
    [pscustomobject]@{
        Description = "Ìnstall the Docker-Microsoft PackageManagement Provider"
        Command     = 'Install-Module -Name DockerMsftProvider -Repository PSGallery -Force'
    }
    [pscustomobject]@{
        Description = "Install the Docker Package"
        Command     = 'Install-Package docker -ProviderName DockerMsftProvider -Force'
    }
    [pscustomobject]@{
        Description = "Restart the Machine"
        Command     = 'Restart-Computer -Force'
    }
)

Interactive-Steps $steps -TaskName "Setup Docker Environment"
