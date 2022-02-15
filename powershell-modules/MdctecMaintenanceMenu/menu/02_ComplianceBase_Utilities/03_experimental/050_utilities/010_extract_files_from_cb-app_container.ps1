. "$Env:MMM_HOME/MdctecMaintenanceMenu/assets/environment/docker/default.env.ps1"

$ErrorActionPreference = "Stop"

$ContainerStatus = $( docker inspect --format '{{ .State.Status }}' ($Env:CB_DOCKER_CONTAINER) )

$ContainerStatusOK = -Not$LastExitCode -And ($ContainerStatus -eq 'running' -OR $ContainerStatus -eq 'exited')

$CbHomeOK = $Env:CB_HOME -And (Test-Path $Env:CB_HOME)


Write-Host
Write-Host "OK:${ContainerStatusOK} `t ContainerStatus='$ContainerStatus'"
Write-Host "OK:$CbHomeOK `t CB_HOME='${Env:CB_HOME}'"
Write-Host

if ($ContainerStatusOK -And $CbHomeOK)
{
    if ($ContainerStatus -eq 'running') {
        Write-Host 'Stopping running container...'
        docker stop $Env:CB_DOCKER_CONTAINER | Out-Null

        if ($LastExitCode -eq 0)
        {
            Write-Host "OK"
        }
    }
    mkdir -Force "$Env:CB_HOME/environment/docker/cb-app/files/nginx/sites-enabled/" | Out-Null
    docker cp "${Env:CB_DOCKER_CONTAINER}:/nginx/sites-enabled/" "$Env:CB_HOME/environment/docker/cb-app/files/nginx/"
}
else{
    Write-Warning "Aborted!"
}
