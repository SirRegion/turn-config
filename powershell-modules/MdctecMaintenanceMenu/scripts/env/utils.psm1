function ApplyDefaults
{
    # Load values directly from file
    $ENV_PATH = "$Env:MMM_HOME/MdctecMaintenanceMenu/assets/env"

    Get-ChildItem "$ENV_PATH" | ForEach-Object {
        $Name = $_.BaseName
        $Value = gc "${ENV_PATH}/$Name"
        SetVariablePersistent "$Name" "$Value"
    }
}

function CoerceDefaults
{
    # Load values directly from file
    $ENV_PATH = "$Env:MMM_HOME/MdctecMaintenanceMenu/assets/env"

    Get-ChildItem "$ENV_PATH" | ForEach-Object {
        $Name = $_.BaseName
        if (-Not(Test-Path "Env:$Name")) {

            $Value = gc "${ENV_PATH}/$Name"

            Write-Host "Using $Name=$Value"
            SetVariablePersistent "$Name" "$Value"
        }
    }
}

function SetVariablePersistent
{
    $Name = $args[0]
    $Value = $args[1]

    Set-Item "Env:$Name" "$Value"
    [Environment]::SetEnvironmentVariable($Name, $Value, 'Machine')
    [Environment]::SetEnvironmentVariable($Name, $Value, 'Process')
}

Export-ModuleMember -Function SetVariablePersistent, ApplyDefaults, CoerceDefaults
