Import-Module MdctecMaintenanceMenu/support/LoadItemsFromPath -DisableNameChecking

function SaveState
{
    param(
        $state
    )
    SaveLocalState $state
    SaveGlobalState $state
}

function LoadState
{
    param(
        $RootPath,
        $ResetState
    )
    $RootDirectory = Get-Item $RootPath

    $state = [pscustomobject]@{
        RootPath = $RootDirectory.parent.FullName

        CurrentRoute = $RootDirectory.Basename

        HideShortcuts = $true

        Items = $null

        CurrentItem = 0
    }

    if ($ResetState)
    {
        $state = ResetState $state
        $state = LoadLocalState $state
    }
    else
    {
        $state = LoadGlobalState $state
        $state = LoadLocalState $state
    }
    return $state
}

function SaveLocalState
{
    param(
        $state
    )
    $state | Select-Object CurrentItem | ConvertTo-Json > $( Join-Path $state.RootPath "$( $state.CurrentRoute )/.mmm-state.json" )
}
function SaveGlobalState
{
    param(
        $state
    )
    $state | Select-Object CurrentRoute, HideShortcuts | ConvertTo-Json > $( Join-Path $state.RootPath '.mmm-state.global.json' )
}

function LoadGlobalState
{
    param(
        $state
    )
    $mmmpath = Join-Path $state.RootPath '.mmm-state.global.json'

    if (Test-Path $mmmpath)
    {
        $loaded = $( Get-Content $mmmpath | ConvertFrom-Json )
    }

    if ($state | Get-Member 'CurrentRoute' )
    {
        if (Test-Path $(Join-Path $state.RootPath $loaded.CurrentRoute) -PathType Container )
        {
            $state.CurrentRoute = $loaded.CurrentRoute
        }
    }

    if ($state | Get-Member 'HideShortcuts')
    {
        $state.HideShortcuts = $loaded.HideShortcuts
    }

    return $state
}
function LoadLocalState
{
    param(
        $state
    )
    $mmmpath = Join-Path $state.RootPath "$( $state.CurrentRoute )/.mmm-state.json"
    $loaded = $null

    if (Test-Path $mmmpath)
    {
        $loaded = $( Get-Content $mmmpath | ConvertFrom-Json )
    }
    else
    {
        $loaded = @{
            CurrentItem = 0
        }
    }

    if ($state | Get-Member 'CurrentItem' )
    {
        $state.CurrentItem = $loaded.CurrentItem
    }
    else
    {
        $state.CurrentItem = 0
    }

    # Load Menu Items
    $state.Items = LoadItemsFromPath $( Join-Path $state.RootPath $state.CurrentRoute )
    return $state

}
function ResetState
{
    param(
        $state
    )
    Write-Host "ResetState $($state.RootPath)"
    if ($state.RootPath)
    {
        Get-ChildItem $state.RootPath -Recurse -Include ".mmm-state.*" | %{ Remove-Item $_ }
    }

    return $state
}

Export-ModuleMember ResetState,LoadState,LoadLocalState,SaveState
