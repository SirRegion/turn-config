Import-Module MdctecMaintenanceMenu\support\interactive-steps.psm1 -DisableNameChecking

$steps = @(
[pscustomobject]@{
    Description = 'Enable access to our Azure registry';
    Command = 'docker login complianceBaseContainerRegistry.azurecr.io --username complianceBaseContainerRegistry --password 1qj9Yn31fr=2Lf7pczlLOlPoTM7wwO19'
}
[pscustomobject]@{
    Description = 'Turn off Windows Defender';
    Command = 'Remove-WindowsFeature Windows-Defender'
}
[pscustomobject]@{
    Description = "Start the Docker Service"
    Command = "Start-Service Docker"
}
)

Interactive-Steps $steps -TaskName "Setup Docker Environment"

