Import-Module MdctecMaintenanceMenu\support\menu -DisableNameChecking

#$VerbosePreference = "Continue"

# Code based on https://github.com/DarkLite1/Toolbox.General/blob/master/Toolbox.General.psm1

<#
    .SYNOPSIS
        Show a interactive Menu based on the content of the speciefied directory path.

    .DESCRIPTION
        - Files become executable items
        - Directories become submenus
 #>

    .EXAMPLE

    #>
Function LoadMenuFromPath
{
    [CmdLetBinding()]
    Param (
        [Parameter(Position = 0)]
        $Path
    )

    $options = Get-ChildItem "$Path" | ForEach-Object {
        if (Test-Path "$_" -PathType Leaf)
        {
            @{
                Label=$(NormalizeBaseName)
                Type="Script"
                Source=$_.FullName
                Script=$_.FullName
            }
        }elseif (Test-Path "$_" -PathType Container){
            @{
                Label="[ $(NormalizeBaseName) ]"
                Type="Submenu"
                Source=$_.FullName
                Script="LoadMenuFromPath $($_.FullName)"
            }
        }
    } | Sort-Object -Property Source

    Menu $options
}

Function NormalizeBaseName{
    $_.BaseName -Replace '^((\d+)_)?(?<Label>.*)','${Label}' -Replace '_',' '
}

Export-ModuleMember -Function LoadMenuFromPath
