Param(
# The path to the files to pull from the container relative to the C:/ directory
    [Parameter(Mandatory = $true)]
    [string]
    $ContainerPath
)
$ErrorActionPreference = "Stop"

# The path on the host where files are copied to
$Env:CB_DOCKER_EXTRACT_PATH = [System.Environment]::GetEnvironmentVariable("CB_DOCKER_EXTRACT_PATH", "User")

if (-Not $Env:CB_DOCKER_EXTRACT_PATH) {
    if ($Env:CB_HOME) {
        $CB_DOCKER_EXTRACT_PATH = Join-Path "$Env:CB_HOME" '/environment/docker/cb-app/extracted'
    }
    else {
        $CB_DOCKER_EXTRACT_PATH = "$PWD"
    }
}
else {
    $CB_DOCKER_EXTRACT_PATH = "$Env:CB_DOCKER_EXTRACT_PATH"
}

do {

    Write-Host
    Write-Host "Would write extracted files to '${CB_DOCKER_EXTRACT_PATH}'"
    Write-Host "You can ..." -Fore Yellow
    Write-Host " 1) press Enter to confirm" -Fore Yellow
    Write-Host " 2) specify another destination directory" -Fore Yellow
    Write-Host " 3) abort with CTRL+C" -Fore Yellow

    $answer = Read-Host
    if (-Not($answer -eq '')) {
        $CB_DOCKER_EXTRACT_PATH = $answer
    }
    $Env:CB_DOCKER_EXTRACT_PATH = $CB_DOCKER_EXTRACT_PATH
    [Environment]::SetEnvironmentVariable('CB_DOCKER_EXTRACT_PATH', $CB_DOCKER_EXTRACT_PATH, 'Process')
    [Environment]::SetEnvironmentVariable('CB_DOCKER_EXTRACT_PATH', $CB_DOCKER_EXTRACT_PATH, 'User')

} while ((-Not$CB_DOCKER_EXTRACT_PATH))


$HostPath = Join-Path "$CB_DOCKER_EXTRACT_PATH" "$ContainerPath"

# make sure destination exists
mkdir $HostPath -Force | Out-Null

# clear destination so that files from container dont mix with existing files
Write-Host "removing files at destination path: $HostPath"
rm -ErrorAction:Ignore -Force -Recurse "$HostPath" | Out-Null



$ContainerStatus = $( docker inspect --format '{{ .State.Status }}' ($Env:CB_DOCKER_CONTAINER) )

$ContainerStatusOK = -Not$LastExitCode -And ($ContainerStatus -eq 'running' -OR $ContainerStatus -eq 'exited')

Write-Host
Write-Host "ContainerStatus = '$ContainerStatus', OK:${ContainerStatusOK}"
Write-Host

if (-Not$ContainerStatusOK) {
    Write-Warning "Aborted!"
    return
}

if ($ContainerStatus -eq 'running') {
    Write-Host 'Stopping running container...'
    docker stop $Env:CB_DOCKER_CONTAINER | Out-Null

    if ($LastExitCode -eq 0)
    {
        Write-Host "OK"
    }
}



Write-Host "copying files from container to host"

# now copy files from container to host
docker cp "${Env:CB_DOCKER_CONTAINER}:/$ContainerPath" "$HostPath"

ls "$HostPath"

