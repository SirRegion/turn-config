############################################################
# Fetch latest updates and copy to the .pending-migrations directory

$PROD_IMAGE_REF = "complianceBaseContainerRegistry.azurecr.io/infrastructure/mdctec-maintenance:latest"

docker pull $PROD_IMAGE_REF

try
{
    $TmpId = $( docker create "$PROD_IMAGE_REF" )

    Remove-Item -ErrorAction:Ignore -Recurse ./.pending-migrations

    docker cp "${TmpId}:/migrations" .pending-migrations/
}
finally
{
    docker rm $TmpId
}

############################################################
# TODO: Verify that an update is required

# (for now just assume yes)


############################################################
# Apply the update if the user allows it
try
{
    if (Test-Path ".pending-migrations/powershell-modules")
    {
        $allow = Read-Host -Prompt "Overwrite $Env:MMM_HOME`? (y/n/t)";
        if ($allow -eq 'y')
        {
            Remove-Item -Recurse $Env:MMM_HOME
            Copy-Item -Recurse .pending-migrations/powershell-modules $Env:MMM_HOME
            "Done!"
            MMM -r
        }
        elseif ($allow -eq 't')
        {
            $DEST = Join-Path "$Env:MMM_HOME" ".update"
            Remove-Item -Recurse $DEST -Force
            Copy-Item -Recurse .pending-migrations/powershell-modules $DEST

            "Copied new files to '$DEST'"
        }
        else
        {
            "Aborted!"
        }
    }
}
finally
{
    Remove-Item -ErrorAction:Ignore -Recurse ./.pending-migrations
}
