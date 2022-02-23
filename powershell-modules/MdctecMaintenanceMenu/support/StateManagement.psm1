Import-Module MdctecMaintenanceMenu/support/LoadItemsFromPath -DisableNameChecking

function SaveState
{
    param(
        $state
    )
    SaveGlobalState $state
    SaveLocalState $state
}

function LoadState
{
    param(
        $RootPath,
        $ResetState
    )
    $RootDirectory = Get-Item $RootPath



    if ($ResetState)
    {
        $state = ResetState $RootDirectory.FullName
        $state = LoadLocalState $state
    }
    else
    {
        $state = [pscustomobject]@{
            RootPath = $RootPath
            CurrentRoute = "menu"
            HideShortcuts = $true
            Items = $null
            CurrentItem = 0
        }
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

    if ($state | Get-Member 'CurrentRoute')
    {
        if (Test-Path $( Join-Path $state.RootPath $loaded.CurrentRoute ) -PathType Container)
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

    if ($state | Get-Member 'CurrentItem')
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
        $RootPath
    )

    if (Test-Path $RootPath)
    {
        Get-ChildItem $RootPath -Recurse -Include ".mmm-state.*" | %{ Remove-Item $_ }
    }

    return [pscustomobject]@{
        RootPath = $RootPath
        CurrentRoute = "menu"
        HideShortcuts = $true
        Items = $null
        CurrentItem = 0
    }
}

Export-ModuleMember ResetState, LoadState, LoadLocalState, SaveState
