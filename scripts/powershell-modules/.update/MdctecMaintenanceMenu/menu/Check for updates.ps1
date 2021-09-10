############################################################
# Fetch latest updates to the .pending-migrations directory
############################################################

docker pull infrastructure/mdctec-maintenance:latest

Remove-Item -ErrorAction:Ignore -Recurse ./.pending-migrations

$id = $(docker create infrastructure/mdctec-maintenance:latest)

docker cp "${id}:/migrations" .pending-migrations/

docker rm $id

############################################################
# Verify that an update is required

# assume yes

############################################################
# Apply the update

#Remove-Item $Env:MMM_HOME

Move-Item .pending-migrations/powershell-modules $Env:MMM_HOME/.update
