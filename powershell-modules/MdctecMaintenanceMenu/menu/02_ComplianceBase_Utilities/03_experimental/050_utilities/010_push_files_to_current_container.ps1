. "$Env:MMM_HOME/MdctecMaintenanceMenu/assets/environment/docker/default.env.ps1"

$ErrorActionPreference = "Stop"

$ContainerStatus = $( docker inspect --format '{{ .State.Status }}' ($Env:CB_DOCKER_CONTAINER) )

$ContainerStatusOK = -Not$LastExitCode -And ($ContainerStatus -eq 'running' -OR $ContainerStatus -eq 'exited')

$CbHomeOK = $Env:CB_HOME -And (Test-Path $Env:CB_HOME)


Write-Host
Write-Host "OK:${ContainerStatusOK}`tContainerStatus = '$ContainerStatus'"
Write-Host "OK:$CbHomeOK`tCB_HOME = '${Env:CB_HOME}'"
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


    # The path to the files to pull from the container relative to the C:/ directory
    $ContainerPath="etc"

    # The path on the host where files are copied to
    $HostPathPrefix="$Env:CB_HOME/environment/docker/cb-app/files"

    # make sure that the target files exist on the host
    if (-Not (Test-Path "$HostPathPrefix/$ContainerPath/*")){
        Write-Host "$HostPathPrefix/$ContainerPath is empty or does not exist" -Fore Red
        return
    }

    # now copy files from host to container
    docker cp "$HostPathPrefix/$ContainerPath/." "${Env:CB_DOCKER_CONTAINER}:/$ContainerPath"
}
else{
    Write-Warning "Aborted!"
}
