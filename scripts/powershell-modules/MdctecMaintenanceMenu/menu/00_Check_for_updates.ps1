############################################################
# Fetch latest updates to the .pending-migrations directory
############################################################
$PROD_IMAGE_REF = "complianceBaseContainerRegistry.azurecr.io/infrastructure/mdctec-maintenance:latest"

docker pull $PROD_IMAGE_REF

$id = $( docker create "$PROD_IMAGE_REF" )

Remove-Item -ErrorAction:Ignore -Recurse ./.pending-migrations

docker cp "${id}:/migrations" .pending-migrations/

docker rm $id

############################################################
# Verify that an update is required

# assume yes

############################################################
# Apply the update


if (Test-Path .pending-migrations/powershell-modules)
{
    $overwrite = Read-Host -Prompt "Overwrite $Env:MMM_HOME`? (y/n/t)";
    if ($overwrite -eq 'y')
    {
        Remove-Item -Recurse $Env:MMM_HOME
        Copy-Item -Recurse .pending-migrations/powershell-modules $Env:MMM_HOME
        "Done!"
    }
    elseif ($overwrite -eq 't')
    {
        $DEST = Join-Path "$Env:MMM_HOME" ".update"
        Copy-Item -Recurse .pending-migrations/powershell-modules $DEST
        "Copied new files to $DEST"
    }
    else
    {
        "Aborted!"
    }
}
