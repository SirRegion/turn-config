$DEST=Join-Path $($env:PSModulePath -Split ';')[0] MdctecMaintenanceMenu

if (Test-Path $DEST) {
    Remove-Item -ErrorAction:Ignore -Recurse $DEST
}
Expand-Archive MdctecMaintenanceMenu.zip $DEST

Import-Module MdctecMaintenanceMenu

[Environment]::SetEnvironmentVariable("MMM_HOME", "$DEST", "User")

