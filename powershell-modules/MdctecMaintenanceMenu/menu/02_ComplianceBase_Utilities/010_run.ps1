if (-Not "$Env:CB_DOCKER_CONTAINER")
{
    Write-Warning "CB_DOCKER_CONTAINER variable was not specified!"
    return
}
else {
    Write-Host "Using CB_DOCKER_CONTAINER $Env:CB_DOCKER_CONTAINER"
}
if (-Not "$Env:CB_VARIANT")
{
    Write-Warning "CB_VARIANT variable was not specified!`nYou need to configure the variant of the ComplianceBase Docker container"
    return
}
else {
    Write-Host "Using CB_VARIANT $Env:CB_VARIANT"
}
if (-Not "$Env:CB_VERSION")
{
    Write-Warning "CB_VERSION variable was not specified!`nYou need to configure the release version of the ComplianceBase Docker container"
    return
}
else {
    Write-Host "Using CB_VERSION $Env:CB_VERSION"
}
if (-Not "$Env:CB_DOCKER_PORT")
{
    Write-Warning "CB_DOCKER_PORT variable was not specified!"
    return
}
else {
    Write-Host "Using CB_DOCKER_PORT $Env:CB_DOCKER_PORT"
}
if (-Not "$Env:CB_DOMAIN")
{
    Write-Warning "CB_DOMAIN variable was not specified!"
    return
}
else {
    Write-Host "Using CB_DOMAIN $Env:CB_DOMAIN"
}

function StartNew
{
    mkdir "$Env:CB_HOME/docker/mnt" -Force

    Write-Host "starting new container '$Env:CB_DOCKER_CONTAINER'"

    $CB_DOCKER_CONTAINER_ID = docker run -d `
        -p "${Env:CB_DOCKER_PORT}:443/tcp" `
        --env "CB_DOMAIN=$Env:CB_DOMAIN" `
        --restart 'unless-stopped' `
        --mount 'type=volume,src=cb-app_data,dst=C:/app/data/mysql' `
        --mount "type=bind,src=$Env:CB_HOME/docker/mnt,dst=C:/mnt" `
        --name "$ENV:CB_DOCKER_CONTAINER" `
        "${Env:MTEC_DOCKER_REGISTRY}/main/${Env:CB_DOCKER_CONTAINER}/${Env:CB_VARIANT}:${Env:CB_VERSION}"

    Write-Host "Container was launched with id $CB_DOCKER_CONTAINER_ID"
}
function Resume
{
    Write-Host "restarting container '$Env:CB_DOCKER_CONTAINER'"
    docker restart $Env:CB_DOCKER_CONTAINER | Out-Null
}

Write-Host
Write-Host "Testing for existing containers..."
Write-Host
$ContainerStatus = docker inspect --format '{{ .State.Status }}' $ENV:CB_DOCKER_CONTAINER 2> $null
if ($LastExitCode -gt 0){
    Write-Host "Could not find any container named like '$Env:CB_DOCKER_CONTAINER'"
    $ContainerStatusOK = $true
}else{
    $ContainerStatusOK = $LastExitCode -gt 0 -OR $ContainerStatus -eq 'exited'
    Write-Host "ContainerStatus='$ContainerStatus'"
}

Write-Host

if (-Not "$ContainerStatusOK") { return }

switch ($ContainerStatus) {
    'running' {
        Write-Warning "Container '$Env:CB_DOCKER_CONTAINER' already up and running! No changes were made."
        Write-Warning "If you meant to restart the existing container, first use the 'stop' menu item"
        break
    }
    'exited' {
        Resume
        break
    }
    Default{
        StartNew
        break
    }
}
