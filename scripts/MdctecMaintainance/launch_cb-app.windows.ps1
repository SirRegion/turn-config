Import-Module MdctecMaintainance\support\interactive-steps.psm1 -DisableNameChecking

$steps = @(
    [pscustomobject]@{
        Description = 'Launch the complianceBase database'
        Command = 'docker run --expose 3306 complianceBaseContainerRegistry.azurecr.io/cb-app/db/windows:demo_2021.0.1'
    },
    [pscustomobject]@{
        Description = 'Launch the complianceBase backend'
        Command = 'docker run --expose 3333 complianceBaseContainerRegistry.azurecr.io/cb-app/backend/windows:demo_2021.0.1'
    },
    [pscustomobject]@{
        Description = 'Launch the complianceBase frontend'
        Command = 'docker run --expose 80 complianceBaseContainerRegistry.azurecr.io/cb-app/frontend/windows:demo_2021.0.1'
    }
)

Interactive-Steps $steps -TaskName "Install and Launch complianceBase app on this machine"
