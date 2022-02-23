$inspect = $( docker volume inspect cb-app_data );

Import-Module MdctecMaintenanceMenu/scripts/env/utils -DisableNameChecking;

Function PrepareDockerVolumes()
{
    if ("$inspect" -eq "[]")
    {
        Write-Host "docker volume 'cb-app_data' does not exist!";
        Write-Host "Creating a new one...";
        docker volume create $ENV:CB_DOCKER_DATA_VOLUME;
    }
    else
    {
        Write-Host "docker volume 'cb-app_data' already exists!";
        Write-Host ""
    }
}

function SetupCbHomePath()
{
    $CB_HOME = $Env:CB_HOME
    if (-Not$CB_HOME)
    {
        Write-Host
        Write-Host "Enter the path to the compliancebase main folder."
        Write-Host "(The folder containing `environment/xampp-control.exe`):"
        Write-Host "Or press enter to use current path $pwd"
        $CB_HOME = Read-Host
        if (-Not$CB_HOME)
        {
            $CB_HOME = $pwd
        }
    }

    while (-Not(Test-Path "$CB_HOME./environment/xampp-control.exe"))
    {
        Write-Warning "$CB_HOME does not contain the file ./environment/xampp-control.exe"

        Write-Host "Enter another path or just hit enter to use this path anyways."
        $answer = Read-Host

        if ($answer)
        {
            $CB_HOME = $answer
        }
        else
        {
            break
        }
    }

    Write-Host "using CB_HOME=$CB_HOME"
    $Env:CB_HOME = $CB_HOME
    [Environment]::SetEnvironmentVariable("CB_HOME", $CB_HOME, 'Machine')
}




######################

SetupCbHomePath
ApplyDefaults
PrepareDockerVolumes
Write-Host
. "$Env:MMM_HOME/MdctecMaintenanceMenu/scripts/configure/dump.ps1"
Write-Host
Write-Host "Sucessfully prepared environment.";
Write-Host "Ready to start the container!";

