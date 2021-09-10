Import-Module MdctecMaintenanceMenu\support\menu -DisableNameChecking

#$VerbosePreference = "Continue"

# Code based on https://github.com/DarkLite1/Toolbox.General/blob/master/Toolbox.General.psm1

<#
    .SYNOPSIS
        Show a interactive Menu based on the content of the speciefied directory path.

    .DESCRIPTION


    .EXAMPLE

    #>
Function LoadMenuFromPath
{
    [CmdLetBinding()]
    Param (
        [Parameter(Position = 0)]
        $Path
    )

    Write-Verbose "LoadMenuFromPath ( Path = '$Path' )"

    $options = Get-ChildItem "$Path" | ForEach-Object {
        if (Test-Path "$_" -PathType Leaf)
        {
            @{
                label=$_.Name
                script=$_.FullName
            }
        }else{
            @{
                label="> $($_.Name)"
                script=$_.FullName
            }
        }
    }

    Menu $options

}

Export-ModuleMember -Function LoadMenuFromPath
