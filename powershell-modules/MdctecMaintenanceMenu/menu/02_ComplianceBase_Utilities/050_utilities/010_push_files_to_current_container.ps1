Param(
# The path to the files to pull from the container relative to the C:/ directory
    [Parameter(Mandatory = $true)]
    [string]
    $ContainerDirectoryPath
)


$ErrorActionPreference = "Stop"
$Env:CB_DOCKER_EXTRACT_PATH = [System.Environment]::GetEnvironmentVariable("CB_DOCKER_EXTRACT_PATH", "User")

if (-Not $Env:CB_DOCKER_EXTRACT_PATH) {
    Write-Warning "CB_DOCKER_EXTRACT_PATH variable not set :("
    Write-Warning "Use the menu item 'pull files from current container'."
    Write-Warning "You can also set this environment variable manually. (Scope: User)"
    return
}
$ContainerStatus = $( docker inspect --format '{{ .State.Status }}' ($Env:CB_DOCKER_CONTAINER) )

$ContainerStatusOK = -Not$LastExitCode -And ($ContainerStatus -eq 'running' -OR $ContainerStatus -eq 'exited')


Write-Host
Write-Host "ContainerStatus = '$ContainerStatus', OK:${ContainerStatusOK}"
Write-Host

if ($ContainerStatusOK)
{
    if ($ContainerStatus -eq 'running') {
        Write-Host 'Stopping running container...'
        docker stop $Env:CB_DOCKER_CONTAINER | Out-Null

        if ($LastExitCode -eq 0)
        {
            Write-Host "OK"
        }
    }

    # The path on the host where files are copied from
    $HostPathPrefix = "$Env:CB_DOCKER_EXTRACT_PATH"

    $HostDirectoryPath = Join-Path $HostPathPrefix $ContainerDirectoryPath
    # make sure that the target files exist on the host
    if (-Not(Test-Path "$HostPathPrefix/$ContainerDirectoryPath/*")) {
        Write-Host "$HostPathPrefix/$ContainerDirectoryPath is empty or does not exist" -Fore Red
        return
    }

    # now copy files from host to container
    Write-Host "copying files from host to container"
    ls "$HostDirectoryPath"
    Write-Host
    Write-Host "docker cp $HostDirectoryPath\. ${Env:CB_DOCKER_CONTAINER}:/$ContainerDirectoryPath"
    docker cp "$HostDirectoryPath\." "${Env:CB_DOCKER_CONTAINER}:/$ContainerDirectoryPath"

    Write-Host "docker start cb-app"
    docker start cb-app
}
else {
    Write-Warning "Aborted!"
}
