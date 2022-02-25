############################################################
# Update feature works like this:
#    1) Pull the latest docker image tagged with
#       `/infrastructure/mdctec-maintenance:latest` from our
#       azure registry.
#    2) Extract desired files from the image and store them
#       in the temporary `.pending-migrations` directory
#    3)
$ErrorActionPreference = "Stop"

if (-Not $Env:MMM_HOME){
    Write-Host "Error: MMM_HOME variable is not set!" -Fore Red
    return
}

# 0) Cleanup & Prepare
Import-Module MdctecMaintenanceMenu/support/StateManagement -DisableNameChecking
ResetState "$Env:MMM_HOME"

# 1) Fetch latest image
if (-Not $Env:MTEC_DOCKER_REGISTRY){
    . "$Env:MMM_HOME/assets/environment/default.env.ps1"
}else {
    $MTEC_DOCKER_REGISTRY = $Env:MTEC_DOCKER_REGISTRY
}


$PROD_IMAGE_REF = "$MTEC_DOCKER_REGISTRY/internal/mdctec-maintenance:latest"
"docker pull $PROD_IMAGE_REF"
docker pull $PROD_IMAGE_REF

# 2) Extract files from docker image
$PENDING_UPDATE_FOLDER = '.pending-updates'
$PENDING_UPDATE_PATH = "$Env:MMM_HOME/$PENDING_UPDATE_FOLDER"
New-Item -Type directory "$PENDING_UPDATE_PATH" -Force

try
{
    # we need to 'create' a container first, so that we can access files and use `docker cp`
    $TmpId = $( docker create "$PROD_IMAGE_REF" )

    # copy new files to the .pending-migrations directory
    Remove-Item -ErrorAction:Ignore -Recurse "$PENDING_UPDATE_PATH"
    docker cp "${TmpId}:/migrations/powershell-modules" "$PENDING_UPDATE_PATH/"
}
finally
{
    # remove the temporary container
    docker rm $TmpId
}



############################################################
# Apply the update if the user allows it
$KEEP_UPDATE_FILES = $true
try
{
    if (Test-Path "$PENDING_UPDATE_PATH/MdctecMaintenanceMenu")
    {
        ############################################################
        # Report available contents:
        Import-Module MdctecMaintenanceMenu\support\GetFolderHash.psm1 -DisableNameChecking

        $CurrentVersion = Get-Content "$Env:MMM_HOME/meta/version"
        $CurrentTimestamp = Get-Content "$Env:MMM_HOME/meta/timestamp"
        $CurrentHash = Get-FolderHash "$Env:MMM_HOME"

        $NewVersion = Get-Content "$PENDING_UPDATE_PATH/MdctecMaintenanceMenu/meta/version"
        $NewTimestamp = Get-Content "$PENDING_UPDATE_PATH/MdctecMaintenanceMenu/meta/timestamp"
        $NewHash = Get-FolderHash "$PENDING_UPDATE_PATH/MdctecMaintenanceMenu"

        ""
        "Currently installed:"
        "{ version: $CurrentVersion, timestamp: $CurrentTimestamp, hash: $CurrentHash }"
        #ls "$Env:MMM_HOME" -Recurse -Name
        ""

        "Latest version:"
        "{ version: $NewVersion, timestamp: $NewTimestamp, hash: $NewHash }"
        #ls "$PENDING_UPDATE_PATH/powershell-modules/MdctecMaintenanceMenu" -Recurse -Name
        ""
        $allow = Read-Host -Prompt "Apply the Update? (y/n/t)";

        if ($allow -eq 'y')
        {
            Remove-Item "$Env:MMM_HOME/*" -Recurse  -Exclude $PENDING_UPDATE_FOLDER
            Copy-Item -Recurse "$PENDING_UPDATE_PATH/MdctecMaintenanceMenu" "$Env:MMM_HOME"
            $KEEP_UPDATE_FILES = $false

            "Done!"
        }
        elseif ($allow -eq 't')
        {
            $KEEP_UPDATE_FILES = $true
            "New files were copied to '$PENDING_UPDATE_PATH'"
        }
        else
        {
            $KEEP_UPDATE_FILES = $false
            "Aborted!"
        }
    }else {
        Write-Host "Error: No such directory: '$PENDING_UPDATE_PATH/MdctecMaintenanceMenu'" -Fore Red
    }
}
finally
{
    if (-Not $KEEP_UPDATE_FILES){
        Write-Host "Removing $PENDING_UPDATE_PATH"
        Remove-Item -ErrorAction:Ignore -Recurse "$PENDING_UPDATE_PATH"
    }
}
