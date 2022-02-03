# Code based on https://github.com/DarkLite1/Toolbox.General/blob/master/Toolbox.General.psm1

Import-Module MdctecMaintenanceMenu\support\deprecated\SimpleMenu.psm1 -DisableNameChecking

Function Interactive-Steps
{
    <#
    .SYNOPSIS
        Execute some commands in "interactively".
 
    .DESCRIPTION
        Execute the specified commands step by step, allowing the user to control the workflow after each step.

    #>

    [CmdLetBinding()]
    Param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [Array]
        $Steps,

        $TaskName
    )

    $currentI = 0

    #region Display the menu
    do
    {
        if ($currentI -ge $Steps.count)
        {
            Write-Host ""
            Write-Host (" There are no further steps steps in the task `"{0}`"! " -f $TaskName) -BackgroundColor Green -ForegroundColor Black
            Write-Host (" The Mdctec Maintenance Menu is now closed. You can open it again by using the command alias 'MMM'!" -f $TaskName)

            return
        }

        $currentStep = $Steps[$currentI]

        Write-Host "`n=============================================================================================="
        Write-Host ("You are about to execute step {0}/{1}) of the task `"{2}`"" -f ($currentI + 1), $Steps.count, $TaskName)

        Write-Host "`nThe step is described with:"

        Write-Host `
            -Object ("`"{0}`"" -f $currentStep.Label) `
            -ForegroundColor 'Green'

        Write-Host "`nThe command to be executed is:"

        Write-Host `
            -Object ($currentStep.Script) `
            -ForegroundColor 'Magenta'

        $selected = & SimpleMenu `
            -Items @( @{ Label = 'execute this step' }, @{ Label = 'skip this step' } ) `
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
            'q' {
                exit
            }
            Default {
                "Returned: '$selected'"
                "Sorry! I do not know what to do here :("
                ""
            }
        }
    } until ( ($selected -eq $null) )
    #endregion


}

Function Execute-Step
{
    Param (
        [Parameter(Mandatory, ValueFromPipeline)]
        $currentStep,
        [Parameter(Mandatory, ValueFromPipeline)]
        $currentI
    )
    Write-Host "________________________________________________________________________________________"
    Write-Host ("> executing step {0}) `"{1}`". Watch what happens ..." -f ($currentI + 1), $currentStep.Label)

    do
    {
        Write-Host $currentStep.Script -ForegroundColor 'Red'
        invoke-expression -Command $currentStep.Script

        Write-Host ("`n> done with step {0}) `"{1}`"" -f ($currentI + 1), $currentStep.Label)

        $selected = & SimpleMenu `
                    -Items @(@{ Label = 'yes, looks allright, continue with the next step' }, @{ Label = 'no, something is wrong here, retry this step' }) `
                    -Question "  Check the log messages above for errors and tell me whether to continue."

        if ($selected -eq '1')
        {
            return $true
        }
        elseif ($selected -eq 'q')
        {
            return $false
        }
    } while ($true)
}

Export-ModuleMember -Function Interactive-Steps
