Param(
    # The path on the host where files are copied to
    [Parameter(Mandatory = $true)]
    [string]
    $HostPathPrefix = "$Env:CB_HOME/environment/docker/cb-app/files",

    # The path to the files to pull from the container relative to the C:/ directory
    [Parameter(Mandatory = $true)]
    [string]
    $ContainerPath
)

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

    $HostPath = "$HostPathPrefix/$ContainerPath"
    Write-Host "Destination Path: $HostPath"
    #    make sure it exists
    mkdir $HostPath -Force | Out-Null

    Write-Host "removing files at destination`n"
    # clear destination so that files from container dont mix with existing files
    rm -ErrorAction:Ignore -Force -Recurse "$HostPath" | Out-Null

    Write-Host "copying files from container to host"

    # now copy files from container to host
    docker cp "${Env:CB_DOCKER_CONTAINER}:/$ContainerPath" "$HostPathPrefix/$ContainerPath"

    ls "$HostPathPrefix/$ContainerPath"
}
else {
    Write-Warning "Aborted!"
}
