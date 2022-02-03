############################################################
# Update feature works like this:
#    1) Pull the latest docker image tagged with
#       `/infrastructure/mdctec-maintenance:latest` from our
#       azure registry.
#    2) Extract desired files from the image and store them
#       in the temporary `.pending-migrations` directory
#    3)

# 0) Cleanup & Prepare
Import-Module MdctecMaintenanceMenu/support/StateManagement -DisableNameChecking
ResetState @{ RootPath="$ENV:MMM_HOME/MdctecMaintenanceMenu"}

# 1) Fetch latest image

$PROD_IMAGE_REF = "complianceBaseContainerRegistry.azurecr.io/infrastructure/mdctec-maintenance:latest"
"docker pull $PROD_IMAGE_REF"
docker pull $PROD_IMAGE_REF

# 2) Extract files
$PENDING_UPDATE_PATH = "./.pending-migrations"
try
{
    # we need to 'create' a container first, so that we can access files and use `docker cp`
    $TmpId = $( docker create "$PROD_IMAGE_REF" )

    # copy new files to the .pending-migrations directory
    Remove-Item -ErrorAction:Ignore -Recurse "$PENDING_UPDATE_PATH"
    docker cp "${TmpId}:/migrations" "$PENDING_UPDATE_PATH/"
}
finally
{
    # remove the temporary container
    docker rm $TmpId
}

############################################################
# Report available contents:
Import-Module MdctecMaintenanceMenu\support\GetFolderHash.psm1 -DisableNameChecking

$CurrentVersion = Get-Content $(Join-Path "$Env:MMM_HOME" "MdctecMaintenanceMenu/meta/version")
$CurrentTimestamp = Get-Content $(Join-Path "$Env:MMM_HOME" "MdctecMaintenanceMenu/meta/timestamp")
$CurrentHash = Get-FolderHash "$Env:MMM_HOME/MdctecMaintenanceMenu"

$NewVersion = Get-Content $(Join-Path "$PENDING_UPDATE_PATH/powershell-modules" "MdctecMaintenanceMenu/meta/version")
$NewTimestamp = Get-Content $(Join-Path "$PENDING_UPDATE_PATH/powershell-modules" "MdctecMaintenanceMenu/meta/timestamp")
$NewHash = Get-FolderHash "$PENDING_UPDATE_PATH/powershell-modules/MdctecMaintenanceMenu"

""
"Currently installed:"
"{ version: $CurrentVersion, timestamp: $CurrentTimestamp, hash: $CurrentHash }"
ls "$Env:MMM_HOME/MdctecMaintenanceMenu" -Recurse -Name
""

"Latest version:"
"{ version: $NewVersion, timestamp: $NewTimestamp, hash: $NewHash }"
ls "$PENDING_UPDATE_PATH/powershell-modules/MdctecMaintenanceMenu" -Recurse -Name
""

############################################################
# Apply the update if the user allows it
try
{
    if (Test-Path "$PENDING_UPDATE_PATH/powershell-modules")
    {
        $allow = Read-Host -Prompt "Apply the Update? (y/n/t)";
        if ($allow -eq 'y')
        {
            Remove-Item -Recurse $Env:MMM_HOME
            Copy-Item -Recurse "$PENDING_UPDATE_PATH/powershell-modules" "$Env:MMM_HOME"
            "Done!"
            MMM -r
        }
        elseif ($allow -eq 't')
        {
            $DEST = Join-Path "$Env:MMM_HOME" ".update"
            New-Item -ErrorAction:Ignore -Type directory "$DEST"
            Remove-Item -ErrorAction:Ignore -Recurse "$DEST/*" -Force

            Copy-Item -Recurse .pending-migrations/powershell-modules "$DEST"

            "Copied new files to '$DEST'"
        }
        else
        {
            "Aborted!"
        }
    }else {
        Write-Host "Error: No such directory: '$PENDING_UPDATE_PATH/powershell-modules'" -Fore Red
    }
}
finally
{
    Remove-Item -ErrorAction:Ignore -Recurse ./.pending-migrations
}
