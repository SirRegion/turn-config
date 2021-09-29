function StopAndRemoveAnyExistingContainers{
    param(
        [Parameter(Mandatory=$true, HelpMessage='enter: $true or $false')]
        $CreateDataBackup
    )
    "docker rm -f cb-app"
    docker rm -f cb-app;
}

StopAndRemoveAnyExistingContainers
