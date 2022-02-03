Import-Module MdctecMaintenanceMenu\support\deprecated\interactive-steps.psm1 -DisableNameChecking

$steps = @(
    [pscustomobject]@{
        Label = 'Enable access to our Azure registry';
        Script = 'docker login complianceBaseContainerRegistry.azurecr.io --username complianceBaseContainerRegistry --password 1qj9Yn31fr=2Lf7pczlLOlPoTM7wwO19'
    }

    [pscustomobject]@{
        Label = "Start the Docker Service"
        Script = "Start-Service Docker"
    }
)

Interactive-Steps $steps -TaskName "Setup Docker Environment"

