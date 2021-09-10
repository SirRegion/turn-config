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
    Write-Host applying update
    Remove-Item -Recurse $Env:MMM_HOME
    Copy-Item -Recurse .pending-migrations/powershell-modules $Env:MMM_HOME
}
