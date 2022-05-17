"Testing for existing container named 'cb-app'"
if ((docker container inspect cb-app) -eq "[]") {
    return
}

Import-Module MdctecMaintenanceMenu/support/SimplePrompt -DisableNameChecking -Force;

Write-Warning "You're about to stop and remove the existing cb-app container."
Write-Warning "You should be sure that no customer data will be lost!"

Write-Host
$AreYouSure = SimplePrompt "Type 'y' to continue, 'n' to abort" -Options y, n


if ($AreYouSure -eq 'y') {

    $CB_BACKUP = SimplePrompt "Create a backup of the current MySQL database? (y/n)" -Options y, n
    if ($CB_BACKUP -eq 'y') {
        try {
            $CB_BACKUP_PATH="/mnt/backup/cb_backend_v0_1/mysqldump_$(get-date -f yyyy-MM-dd_HHmm).sql"

            docker exec "$Env:CB_DOCKER_CONTAINER" powershell -C "mkdir /mnt/backup/cb_backend_v0_1 -Force | Out-Null; mysqldump --user='root' --password='OwobEB7M' --databases cb_backend_v0_1 > '$CB_BACKUP_PATH'"

            if ($LastExitCode -ne 0) {
                "Aborted, Code $LastExitCode! Container status was not changed."
                exit $LastExitCode
            }

            "Backup was saved to '$Env:CB_HOME\docker$CB_BACKUP_PATH'"
        }
        catch  {
            "Aborted, Code $LastExitCode! Container status was not changed."
            exit 1
        }
    }

    "docker rm -f cb-app"
    docker rm -f cb-app;
}
else {
    "Aborted!"
}
