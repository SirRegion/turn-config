Import-Module MdctecMaintenance\support\interactive-steps.psm1 -DisableNameChecking

# Enable Hyper-V and Containers Windows Features
# (may require a manual reboot afterwards! Watch the console output to see if this is required)
#Enable-WindowsOptionalFeature -Online -FeatureName $("Microsoft-Hyper-V", "Containers") -All -NoRestart

$steps = @(
#    [pscustomobject]@{
#        Description = 'Enable "Hyper-V" and "Containers" Features'
#        Command     = 'Enable-WindowsOptionalFeature -Online -FeatureName $("Microsoft-Windows-Subsystem-Linux", "VirtualMachinePlatform") -All -NoRestart'
#    },
    [pscustomobject]@{
        Description = 'Enable "Hyper-V" and "Containers" Features'
        Command     = 'Enable-WindowsOptionalFeature -Online -FeatureName $("Hyper-V", "Containers") -All -IncludeAllSubFeature -NoRestart'
    }
    [pscustomobject]@{
        Description = 'Enable Nested Virtualization'
        Command     = 'Get-VM *WinContainerHost* | Set-VMProcessor -ExposeVirtualizationExtensions $true'
    }
    [pscustomobject]@{
        Description = "Setup Docker Repository"
        Command     = 'Install-Module -Name DockerMsftProvider -Repository PSGallery -Force'
    }
    [pscustomobject]@{
        Description = "Install the Docker Package"
        Command     = 'Install-Package docker -ProviderName DockerMsftProvider -Force'
    }
    [pscustomobject]@{
        Description = "Download LCow"
        Command = "Invoke-WebRequest -Uri https://github.com/linuxkit/lcow/releases/download/v4.14.35-v0.3.9/release.zip -UseBasicParsing -OutFile release.zip; Expand-Archive release.zip -DestinationPath $Env:ProgramFiles\Linux Containers\."
    }
)

Interactive-Steps $steps -TaskName "Setup Docker Environment"
