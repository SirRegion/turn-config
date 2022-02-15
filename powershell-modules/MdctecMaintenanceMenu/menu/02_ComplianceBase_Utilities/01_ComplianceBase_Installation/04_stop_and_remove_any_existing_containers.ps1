"Testing for existing container named 'cb-app'"
if ((docker container inspect cb-app) -eq "[]"){
    return
}

Import-Module MdctecMaintenanceMenu/support/SimplePrompt -DisableNameChecking -Force;

Write-Warning "You're about to stop and remove the existing cb-app container."
Write-Warning "You should be sure that no customer data will be lost!"
Write-Warning "If the data was mounted with a docker volume (which is the default behaviour) it should be safe to continue."
Write-Host

$AreYouSure = SimplePrompt "Type 'y' to continue, 'n' to abort" -Options y,n

if ($AreYouSure -eq 'y'){
    "docker rm -f cb-app"
    docker rm -f cb-app;
}
else{
    "Aborted!"
}
