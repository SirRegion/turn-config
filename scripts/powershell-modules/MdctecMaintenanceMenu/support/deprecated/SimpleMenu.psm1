Import-Module MdctecMaintenanceMenu\support\LoadItemsFromPath -DisableNameChecking


# Code based on https://github.com/DarkLite1/Toolbox.General/blob/master/Toolbox.General.psm1

<#
    .SYNOPSIS
        Show a menu in the console
#>
Function SimpleMenu
{
    [CmdLetBinding()]
    Param (
        [Parameter(Mandatory, Position=0)]
        [Array]
        $Items,
        $QuitSelector = @{ 'q' = 'Quit' },
        $displayTemplate = '{0}) {1}',
        $Question = "Your options are:",
        $SelectionPrompt = "Select an option"
    )
    Write-Verbose "SimpleMenu:"
    $($Items | Format-List)
    #region Build hash table with selector and value
    $hash = [Ordered]@{ }

    for ($i = 0; $i -lt $Items.Count; $i++) {
        $key = "$( $i + 1 )";
        $value = $Items[$i]
        $hash[$key] = $value
    }
    #endregion

    #region Get the quit selector key if there is one
    $quitSelectorKey = $null

    if ($QuitSelector)
    {
        if ($QuitSelector.Keys[0] -match '^[0-9]+$')
        {
            throw 'The quit selector cannot be a number'
        }
        if ($QuitSelector.Count -ne 1)
        {
            throw 'The quit selector can hold only one key value pair'
        }

        $quitSelectorKey = $quitSelector.GetEnumerator() |
                Select-Object -ExpandProperty Key

        if ($quitSelectorKey -isNot [String])
        {
            throw 'The quit selector key needs to be of type string'
        }
    }
    #endregion

    #region print the menu
    do
    {
        Write-Host $Question
        foreach ($item in $hash.getEnumerator())
        {
            RenderItem $item.Key $item.Value
        }
        if ($QuitSelector)
        {
            $params = @{
                Object = $displayTemplate -f
                $quitSelectorKey, "$( $QuitSelector.Values[0] )"
                ForegroundColor = 'yellow'
            }
            Write-Host @params
        }

        $selected = Read-Host -Prompt $SelectionPrompt

        if ($selected -eq $quitSelectorKey)
        {
            return
        }
    } until (
    ($hash.Keys -contains $selected) -or
            ($selected -eq $quitSelectorKey)
    )
    #endregion

    #region Execute selected item
    ExecItem $hash[$selected]
    #endregion
}


$defaults = @{
    ForegroundColor = 'Yellow'
    BackgroundColor = 'Black'
}


Function RenderItem
{
    $Key = $Args[0]
    $Type = $Args[1].Type
    $Label = $Args[1].Label

    switch ($Type)
    {
        'Submenu' {
            Write-Host @defaults "$Key) " -NoNewline
            Write-Host $Label -BackgroundColor Yellow -ForegroundColor Black
        }
        'Script'{
            Write-Host @defaults -Object $( '{0}) {1}' -f $Key, $Label )
        }
        default {
            Write-Host @defaults -Object $( '{0}) {1}' -f $Key, $Label )
        }
    }


}

Function ExecItem
{
    $Type = $Args[0].Type
    $Label = $Args[0].Label
    $Script = $Args[0].Script

    Invoke-Expression $Script
}

Export-ModuleMember -Function SimpleMenu
