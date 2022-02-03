function SaveState
{
    param(
        $state
    )
    $state | Select-Object Selected, Expanded, HideShortcuts | ConvertTo-Yaml > $( Join-Path $state.RootPath '.mmm-state.yml' )
}

function LoadState
{
    param(
        $RootPath,
        $ResetState
    )
    $RootPath = (Get-Item $RootPath).FullName
    $Source ='menu.yml'

    $state = [pscustomobject]@{
        RootPath = "$RootPath"

        Source = $Source

        HideShortcuts = $true

        Items = $null

        Selected = $null

        Expanded = @{}
    }


    if ($ResetState)
    {
        ResetState $state
    }
    else
    {
        $state = LoadStateFromFile $state
    }

    $state.Items = Get-Content $(Join-Path $RootPath $Source) | ConvertFrom-Yaml

    return $state
}



function LoadStateFromFile
{
    param(
        $state
    )
    $ymlFilePath = Join-Path $state.RootPath '.mmm-state.yml'

    if (Test-Path $ymlFilePath)
    {
        $loaded = Get-Content $ymlFilePath | ConvertFrom-Yaml

        if ($loaded.Selected -match '(\d+)(\/\d+)*')
        {
            $state.Selected = $loaded.Selected
        }
        $state.Expanded = $loaded.Expanded
        $state.HideShortcuts = $loaded.HideShortcuts
    }

    return $state
}
function ResetState
{
    param(
        $state
    )
    $ymlFilePath = Join-Path $RootPath '.mmm-state.yml'

    Write-Host "ResetState $( $ymlFilePath )"
    if (Test-Path "$ymlFilePath")
    {
        Remove-Item "$ymlFilePath"
    }

    return $state
}

Export-ModuleMember ResetState, LoadState, SaveState
