if (-Not "$Env:CB_DOCKER_REGISTRY")
{
    Write-Warning "CB_DOCKER_REGISTRY variable was not specified!"
    return
}else{
    Write-Host "Using CB_DOCKER_REGISTRY $Env:CB_DOCKER_REGISTRY"
}
if (-Not "$Env:CB_DOCKER_CONTAINER")
{
    Write-Warning "CB_DOCKER_CONTAINER variable was not specified!"
    return
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
Write-Host ""
Write-Host "docker pull ${Env:CB_DOCKER_REGISTRY}/main/${Env:CB_DOCKER_CONTAINER}/${Env:CB_VARIANT}:${Env:CB_VERSION}"
docker pull "${Env:CB_DOCKER_REGISTRY}/main/${Env:CB_DOCKER_CONTAINER}/${Env:CB_VARIANT}:${Env:CB_VERSION}"
