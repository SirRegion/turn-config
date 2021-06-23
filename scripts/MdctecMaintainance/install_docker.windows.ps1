Import-Module MdctecMaintainance\support\interactive-steps.psm1 -DisableNameChecking

# Enable Hyper-V and Containers Windows Features
# (may require a manual reboot afterwards! Watch the console output to see if this is required)
#Enable-WindowsOptionalFeature -Online -FeatureName $("Microsoft-Hyper-V", "Containers") -All -NoRestart

$steps = @(
    [pscustomobject]
    @{
        Description = 'Enable "Hyper-V" and "Containers" Features'
        Command     = 'Enable-WindowsOptionalFeature -Online -FeatureName $("Microsoft-Hyper-V", "Containers") -All -NoRestart'
    },
    @{
        Description = "Setup Docker Repository"
        Command     = 'Install-Module -Name DockerMsftProvider -Repository PSGallery -Force'
    },
    @{
        Description = "Install the Docker Package"
        Command     = 'Install-Package docker -ProviderName DockerMsftProvider -Force'
    }
)

Interactive-Steps $steps -TaskName "Setup Docker Environment"
