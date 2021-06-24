Import-Module MdctecMaintenance\support\interactive-steps.psm1 -DisableNameChecking

$steps = @(
#    [pscustomobject]@{
#        Description = 'Launch the complianceBase database'
#        Command = 'docker run --pull always -p 3306:3306 --name cb-app_db complianceBaseContainerRegistry.azurecr.io/cb-app/db/windows:demo_2021.0.1'
#    },
#    [pscustomobject]@{
#        Description = 'Launch the complianceBase backend'
#        Command = 'docker run --pull always -p 3333:3333 --name cb-app_backend complianceBaseContainerRegistry.azurecr.io/cb-app/backend/windows:demo_2021.0.1'
#    },
    [pscustomobject]@{
        Description = 'Pull the latest version of the frontend application. (This can take some time)'
        Command = 'docker pull complianceBaseContainerRegistry.azurecr.io/cb-app/frontend/windows:demo_2021.0.1'
    }
    [pscustomobject]@{
        Description = 'Launch the complianceBase frontend'
        Command = 'docker run --name cb-app_frontend -p 80:80 --rm complianceBaseContainerRegistry.azurecr.io/cb-app/frontend/windows:demo_2021.0.1'
    }
)

Interactive-Steps $steps -TaskName "Install and Launch complianceBase app on this machine"
