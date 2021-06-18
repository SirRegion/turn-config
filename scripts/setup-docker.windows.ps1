# Enable Hyper-V and Containers Windows Features
# (may require a manual reboot afterwards! Watch the console output to see if this is required)
Enable-WindowsOptionalFeature -Online -FeatureName $("Microsoft-Hyper-V", "Containers") -All -NoRestart

