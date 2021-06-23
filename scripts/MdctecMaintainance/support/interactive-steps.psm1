# Code based on https://github.com/DarkLite1/Toolbox.General/blob/master/Toolbox.General.psm1

Import-Module MdctecMaintainance\support\show-menu.psm1 -DisableNameChecking

Function Interactive-Steps
{
    <#
    .SYNOPSIS
        Execute some commands in "interactive" mode.
 
    .DESCRIPTION
        Execute the specified commands step by step, allowing the user to interupt or modify the workflow after each step.

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

    #>

    [CmdLetBinding()]
    Param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [Array]$Steps,
        $TaskName
    )

    $currentI = 1

    #region Display the menu
    do
    {
        $currentStep = $Steps[$currentI]

        Write-Host "`n=============================================================================================="
        Write-Host ("You are about to execute step {0}) of the task `"{1}`"" -f $currentI, $TaskName)

        Write-Host "`nThe step is described with:"

        Write-Host `
            -Object ("`"{0}`"" -f $currentStep.Description ) `
            -ForegroundColor 'Green'

        Write-Host "`nThe command to be executed is:"

        Write-Host `
            -Object ($currentStep.Command) `
            -ForegroundColor 'Magenta'

        $selected = & Show-Menu `
            -Items @('execute this step', 'skip this step') `
            -Question ("`nYour options are:")

        switch ($selected)
        {
            '1' {
                $success = Execute-Step $currentStep $currentI

                if ($success -eq $true)
                {
                    $currentI++
                }
            }
            '2' {
                "skipping..."
                $currentI++
            }
            Default {
                "Sorry! I do not know what to do here :("
            }
        }
    } until ( ($selected -eq $null) -or ($currentI -gt $Items.Length) )
    #endregion


}

Function Execute-Step{
    Param (
        [Parameter(Mandatory, ValueFromPipeline)]
        $currentStep,
        [Parameter(Mandatory, ValueFromPipeline)]
        $currentI
    )
    Write-Host "________________________________________________________________________________________"
    Write-Host ("> executing step {0}) {1}. Watch what happens ..." -f $currentI,$currentStep.Description)


    Write-Host $currentStep.Command -ForegroundColor 'Red'
    invoke-expression -Command $currentStep.Command

    Write-Host ("`n> done with step {0}) {1}" -f $currentI,$currentStep.Description)

    $selected = & Show-Menu `
                    -Items @('yes, looks allright, continue with the next step', 'no, something is wrong here, retry this step') `
                    -Question "  Check the log messages above for errors and tell me whether to continue."

    return $selected -eq '1'
}

Export-ModuleMember -Function Interactive-Steps
