# Code based on https://github.com/DarkLite1/Toolbox.General/blob/master/Toolbox.General.psm1

Function Show-Menu {
    <#
    .SYNOPSIS
        Show a selection menu in the console
 
    .DESCRIPTION
        Allow the user to select an option int he console and return the 
        selected value afterwards. When the parameter `-QuitSelector` is used
        the user is also able to select nothing and just leave the menu with no
        return value.
 
    .EXAMPLE
        Show-Menu -Items @('a', 'b', 'c') -QuitSelector @{ 'Q' = 'Quit' }
 
        1) a
        2) b
        3) c
        Q) Quit
        Select an option:
 
        Displays the menu with an option to select nothing by pressing `q`
 
    .EXAMPLE
        $fruits = @(
            [PSCustomObject]@{
                Name  = 'banana'; Color = 'yellow'; Shape = 'long'
            }
            [PSCustomObject]@{
                Name  = 'kiwi'; Color = 'green'; Shape = 'oval'
            }
            [PSCustomObject]@{
                Name  = 'apples'; Color = 'red'; Shape = 'round'
            }
        )
 
        $params = @{
            Items           = $fruits 
            QuitSelector    = $null 
            SelectionPrompt = 'Select a fruit you like:'
        }
        $myFavoriteFruit = Show-Menu @params
 
        1) @{Name=banana; Color=yellow; Shape=long}
        2) @{Name=kiwi; Color=green; Shape=oval}
        3) @{Name=apples; Color=red; Shape=round}
        'Select a fruit you like:'
        
        Displays the menu where the user is forced to select one of the 3 
        options. When selected the result is stored in the variable 
        '$myFavoriteFruit'
    #>

    [CmdLetBinding()]
    Param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [Array]$Items,
        $QuitSelector = @{ 'q' = 'Quit' },
        $displayTemplate = '{0}) {1}',
        $Question= "Your options are:",
        $SelectionPrompt = "Select an option"
    )

    #region Build hash table with selector and value
    $hash = [Ordered]@{}

    for ($i = 0; $i -lt $Items.Count; $i++) {
        $key = "$($i+1)"; $value = $Items[$i]
        $hash[$key] = $value
    }
    #endregion

    #region Get the quit selector key if there is one
    $quitSelectorKey = $null

    if ($QuitSelector) {
        if ($QuitSelector.Keys[0] -match '^[0-9]+$') {
            throw 'The quit selector cannot be a number'
        }
        if ($QuitSelector.Count -ne 1) {
            throw 'The quit selector can hold only one key value pair'
        }

        $quitSelectorKey = $quitSelector.GetEnumerator() |
                Select-Object -ExpandProperty Key

        if ($quitSelectorKey -isNot [String]) {
            throw 'The quit selector key needs to be of type string'
        }
    }
    #endregion

    #region Display the menu
    do {
        Write-Host $Question
        foreach ($item in $hash.getEnumerator()) {
            $params = @{
                Object          = $displayTemplate -f
                $item.key, "$($item.Value)"
                ForegroundColor = 'yellow'
            }
            Write-Host @params
        }
        if ($QuitSelector) {
            $params = @{
                Object          = $displayTemplate -f
                $quitSelectorKey, "$($QuitSelector.Values[0])"
                ForegroundColor = 'yellow'
            }
            Write-Host @params
        }

        $selected = Read-Host -Prompt $SelectionPrompt

    } until (
    ($hash.Keys -contains $selected) -or
            ($selected -eq $quitSelectorKey)
    )
    #endregion

    #region Return the selected value
    if ($selected -ne $quitSelectorKey) {
        $returnValue = $selected
        Write-Verbose "Selected: $selected) $returnValue"
        $returnValue
    }
    #endregion
}

Export-ModuleMember -Function Show-Menu
