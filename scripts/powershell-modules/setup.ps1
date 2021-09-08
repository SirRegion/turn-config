$DEST = $PSScriptRoot

$CURRENT = [Environment]::GetEnvironmentVariable("MMM_HOME", "User")

if ($CURRENT){
    Write-Host "CURRENT: $CURRENT"
}
$env:MMM_HOME="$DEST"
Write-Host "MMM_HOME=$DEST"
[Environment]::SetEnvironmentVariable("MMM_HOME", "$DEST", "User")

Write-Host "Updating PSModulePath"

[Environment]::SetEnvironmentVariable("PSModulePath", "$env:PSModulePath;$DEST", "User")
