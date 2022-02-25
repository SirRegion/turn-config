function ApplyDefaults
{
    # Load values directly from file
    $ENV_PATH = "$Env:MMM_HOME/assets/env"

    Get-ChildItem "$ENV_PATH" | ForEach-Object {
        $Name = $_.BaseName
        $Value = gc "${ENV_PATH}/$Name"
        SetVariablePersistent "$Name" "$Value"
    }
}

function CoerceDefaults
{
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]
        $RootPath
    )

    if (-Not($Env:MMM_HOME -And "$Env:MMM_HOME".EndsWith('MdctecMaintenanceMenu'))) {
        $Env:MMM_HOME = "$RootPath"
        Write-Warning "Updated MMM_HOME=$Env:MMM_HOME"
        [Environment]::SetEnvironmentVariable("MMM_HOME", "$RootPath", "User")
    }


    # Load values directly from file
    $ENV_PATH = "$Env:MMM_HOME/assets/env"

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
