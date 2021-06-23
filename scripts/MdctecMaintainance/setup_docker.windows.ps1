Import-Module MdctecMaintainance\support\interactive-steps.psm1 -DisableNameChecking

$steps = @(
    [pscustomobject]@{
        Description = 'Enable access to our Azure registry';
        Command = 'docker login complianceBaseContainerRegistry.azurecr.io --username complianceBaseContainerRegistry --password 1qj9Yn31fr=2Lf7pczlLOlPoTM7wwO19'
    }
)

Interactive-Steps $steps -TaskName "Setup Docker Environment"
