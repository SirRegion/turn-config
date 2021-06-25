Import-Module MdctecMaintenance\support\interactive-steps.psm1 -DisableNameChecking

$steps = @(
    [pscustomobject]@{
        Description = "Enable Linux Container Support"
        Command     = '[Environment]::SetEnvironmentVariable(“LCOW_SUPPORTED”, “1”, “Machine”)'
    }
    [pscustomobject]@{
        Description = "Setup linux to be the default"
        Command     = '[Environment]::SetEnvironmentVariable(“LCOW_API_PLATFORM_IF_OMITTED”, “linux”, “Machine”)'
    }
    [pscustomobject]@{
        Description = 'Restart Docker';
        Command = 'Restart-Service Docker'
    }
    [pscustomobject]@{
        Description = 'Check docker environment';
        Command = 'docker info'
    }
    [pscustomobject]@{
        Description = 'Run a test container to see if is working';
        Command = 'docker run --rm -it --platform=linux ubuntu bash; docker ps -a'
    }
    [pscustomobject]@{
        Description = 'Enable access to our Azure registry';
        Command = 'docker login complianceBaseContainerRegistry.azurecr.io --username complianceBaseContainerRegistry --password 1qj9Yn31fr=2Lf7pczlLOlPoTM7wwO19'
    }
)

Interactive-Steps $steps -TaskName "Setup Docker Environment"
