if (-Not "$Env:CB_DOCKER_CONTAINER")
{
    Write-Warning "CB_DOCKER_CONTAINER variable was not specified!"
}else{
    Write-Host "Using CB_DOCKER_CONTAINER $Env:CB_DOCKER_CONTAINER"
}
if (-Not "$Env:CB_VARIANT")
{
    Write-Warning "CB_VARIANT variable was not specified!`nYou need to configure the variant of the ComplianceBase Docker container"
    return
}else{
    Write-Host "Using CB_VARIANT $Env:CB_VARIANT"
}
if (-Not "$Env:CB_VERSION")
{
    Write-Warning "CB_VERSION variable was not specified!`nYou need to configure the release version of the ComplianceBase Docker container"
    return
}else{
    Write-Host "Using CB_VERSION $Env:CB_VERSION"
}
if (-Not "$Env:CB_DOCKER_PORT")
{
    Write-Warning "CB_DOCKER_PORT variable was not specified!"
    return
}else{
    Write-Host "Using CB_DOCKER_PORT $Env:CB_DOCKER_PORT"
}


Write-Host
Write-Host "Testing if container can be started..."
Write-Host

$ContainerStatus = docker inspect --format '{{ .State.Status }}' $ENV:CB_DOCKER_CONTAINER 2> $null
$ContainerStatusOK = $LastExitCode -gt 0

Write-Host "ContainerStatus='$ContainerStatus', OK:${ContainerStatusOK}"
if (-Not $ContainerStatusOK){
    Write-Host "Error: Make sure that there is no container with name '$Env:CB_DOCKER_CONTAINER'" -Fore Red
    return
}


Write-Host

Write-Host "starting container 'cb-app'"

docker run -d `
    -p "${Env:CB_DOCKER_PORT}:443/tcp" `
    --mount 'type=volume,src=cb-app_data,dst=C:/app/data/mysql' `
    --name "$ENV:CB_DOCKER_CONTAINER" `
    "${Env:MTEC_PROD_REGISTRY}/main/${Env:CB_DOCKER_CONTAINER}/${Env:CB_VARIANT}:${Env:CB_VERSION}"


