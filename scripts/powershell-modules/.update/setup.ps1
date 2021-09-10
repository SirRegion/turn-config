$DEST = $PSScriptRoot

$MMM_HOME = [Environment]::GetEnvironmentVariable("MMM_HOME", "User")
$PSModulePath = [Environment]::GetEnvironmentVariable("PSModulePath", "User")
if ($MMM_HOME)
{
    if ($MMM_HOME -eq $DEST)
    {
        Write-Host "You have already setup the path to this powershell module. You don't have to call this everytime!" -Fore Yellow
    }

    Write-Host "Current MMM_HOME = $MMM_HOME"
    "Current PSModulePath:"
    $PSModulePath -Split ';'
    Write-Host "Removing old path"
    $PSModulePath = $($env:PSModulePath -Split ';' | Where { ($_ -ne $MMM_HOME) -and ($_ -ne [String]::Empty) }) -Join ';'
}
Write-Host "Set MMM_HOME = $DEST"
$MMM_HOME = "$DEST"
$Env:MMM_HOME= "$MMM_HOME"
[Environment]::SetEnvironmentVariable("MMM_HOME", "$MMM_HOME", "User")

Write-Host "Updating PSModulePath"
$PSModulePath="$PSModulePath;$DEST"
$PSModulePath -Split ';'

$env:PSModulePath = $PSModulePath

[Environment]::SetEnvironmentVariable("PSModulePath", "$PSModulePath", "User")


