Import-Module MdctecMaintenanceMenu/support/StateManagement -DisableNameChecking

# Inspired from https://www.koupi.io/post/creating-a-powershell-console-menu

function FancyMenu
{
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]
        $RootPath,

        [Parameter(Position = 1)]
        [boolean]
        $ResetState = $false
    )
    $schedule = @{
        Reload = $null
    }

    # 1. Initialize State
    $state = $( LoadState $RootPath $ResetState )

    # 2. Draw the static Header Section
    DrawHeader

    # Remember where the static menu section ends.
    # Everything below this curor position updated
    # every frame. (i.e. each time 'DrawMenu' is called)
    $MenuStartPosition = $host.UI.RawUI.CursorPosition

    # Draw the menu items for the first time
    DrawMenu

    do
    {
        # Read and handle any keyboard input
        # (This might re-draw the menu)
        $continue = HandleMenuKey

        # Save state every time the user presses a key
        SaveState $state

        # Update the end position
        $MenuEndPosition = $host.UI.RawUI.CursorPosition

    } while ($continue)


    if ($schedule.Reload)
    {
        Import-Module MdctecMaintenanceMenu/support/FancyMenu -Force -DisableNameChecking

        FancyMenu $RootPath
    }
}

$KEY_ENTER = 13
$KEY_LEFT = 37
$KEY_UP = 38
$KEY_RIGHT = 39
$KEY_DOWN = 40
$KEY_HELP = 72
$KEY_QUIT = 81
$KEY_1 = 49
$KEY_2 = 50
$KEY_3 = 51
$KEY_4 = 52
$KEY_5 = 53
$KEY_6 = 54
$KEY_7 = 55
$KEY_8 = 56
$KEY_9 = 57
$KEY_C = 67
$KEY_F5 = 116

function HandleMenuKey
{

    $press = $host.ui.rawui.readkey("NoEcho,IncludeKeyDown")
    $key = $press.virtualkeycode

    switch ($key)
    {
        $KEY_ENTER {
            # return the menu item at the current position
            $ci = GetCurrentItem
            return ExecItem @ci
        }
        $KEY_UP {
            if ($state.CurrentItem -gt 0)
            {
                $state.CurrentItem--
                DrawMenu
            }
        }
        $KEY_DOWN {
            if ($state.CurrentItem -lt $state.Items.count - 1)
            {
                $state.CurrentItem++
                DrawMenu
            }
        }
        $KEY_RIGHT {
            $newpath = Get-Item $( GetCurrentItem ).Source

            if (Test-Path $newpath -Type Container)
            {
                $state.CurrentRoute = Join-Path $state.CurrentRoute $newpath.Basename
                LoadLocalState $state
                DrawMenu

            }
            else
            {
                Write-Warning "Not a valid submenu!"
            }
        }
        $KEY_LEFT {

            $newpath = Split-Path $state.CurrentRoute
            if ($newpath -eq "")
            {
                Write-Warning "There is no parent menu!"
            }
            elseif ($newpath)
            {
                $state.CurrentRoute = $newpath
                LoadLocalState $state

                DrawMenu
            }
        }
        # Number-Keys 1-9:
        { $_ -ge $KEY_1 -and $_ -le $KEY_9 } {
            $n = $key - $KEY_1
            if ($n -lt $state.Items.Count)
            {
                $state.CurrentItem = $n
                DrawMenu
            }
            else
            {
                Write-Warning "No $n'th menu item!"
            }
        }
        $KEY_C{
            $ci = GetCurrentItem
            if ($ci.Type -eq 'Script')
            {
                Set-Clipboard -Value "$( Get-Content $ci.Source )"
                DrawLine "Copied selected command to clipboard." -Foreground 'Green'
            }else{
                Write-Warning "Not a 'Script' Item!"
            }
        }
        $KEY_HELP {
            $state.HideShortcuts = -Not$state.HideShortcuts
            DrawMenu
        }
        $KEY_F5 {
            $schedule.Reload = $true
            return $false
        }
        $KEY_QUIT{
            return $false
        }
        default {
            DrawLine "Unexpected KeyCode: $key" -ForeGround 'Yellow'
        }
    }
    return $true
}

function ExecItem
{
    param (
        $Item
    )

    switch ($Item.Type)
    {
        'Script' {
            Write-Verbose "Invoke `"$( $Item.Source )`" in separate shell"

            $Script=@"
Write-Host "Executing script for: $($Item.Label)..." -Foreground 'Green';
Write-Host;
$($Item.Source);
Write-Host;
Write-Host "Done with task: $($Item.Label)." -Foreground 'Green';
Read-Host 'press ENTER to close this window'
exit 0;
"@

            start-process powershell -ArgumentList "-noexit -command `"$Script`""
            return $true
        }
        'Submenu'{
            Write-Warning "Executing a submenu item is not supported yet! If you meant to enter the submenu use the 'right' key."
            return $true
        }
        Default {
            Write-Warning "Unknown item type: $Item"
            return $true
        }
    }
}

function GetCurrentItem
{
    $state.Items[$state.CurrentItem]
}

function DrawHeader
{
    DrawLine
    DrawLine " Welcome to the MDCTec Maintenance Menu! (alias: MMM) " -BackgroundColor White -ForegroundColor Black

    function DrawInfoLine{
        DrawLine "  $($Args[0])" -NoNewLine -Foreground 'DarkGray'
        DrawLine "  $($Args[1])" -Foreground 'Gray'
    }
    $VersionPath = Join-Path $state.RootPath 'meta/version'
    if (Test-Path "$VersionPath")
    {
        DrawInfoLine "Version:          " "$( Get-Content $VersionPath)"
    }

    $TimestampPath = Join-Path $state.RootPath 'meta/timestamp'
    if (Test-Path "$TimestampPath")
    {
        DrawInfoLine "Last_modified:    " "$( Get-Content $TimestampPath )"
    }

    DrawInfoLine "SourcePath:       " "$( $state.RootPath )"

    DrawInfoLine "Working Directory:" "$PWD"

    DrawLine
}

function DrawMenu
{
    # Reset the cursor position to the start of the menu
    # (start overwriting old content)
    $host.UI.RawUI.CursorPosition = $MenuStartPosition

    DrawLine "Current Route: $( $state.CurrentRoute )"
    DrawLine

    $i = 0
    foreach ($Item in $state.Items)
    {
        DrawItem $Item
        $i++
    }

    DrawLine

    if ($state.HideShortcuts -eq $true)
    {
        DrawLine "Press 'h' to show available keyboard shortcuts" -ForegroundColor "DarkGray"
    }
    else
    {
        PrintKeyboardShortcuts
    }

    # ===================
    # Overwrite the remaining part of the previous menu
    # (in case it had more lines)
    DrawEnd

    # Remember the position of the bottom-most output, so we can overdraw it.
    $MenuEndPosition = $host.UI.RawUI.CursorPosition
}
function DrawItem
{
    param(
        [Parameter(Position = 0)]
        $Item
    )
    $Label = $Item.Label
    $Type = $Item.Type

    $RenderParams = @{ }

    if ($i -eq $state.CurrentItem)
    {
        $RenderParams.BackgroundColor = 'Yellow'
        $RenderParams.ForegroundColor = 'Black'
    }
    else
    {

    }

    switch ($Type)
    {
        'Script' {
            DrawLine  " $( $i + 1 )) $Label " @RenderParams
        }
        'Submenu'{
            DrawLine  " $( $i + 1 )) $Label > " @RenderParams
        }
        Default {
            DrawLine  " $( $i + 1 )) $Label " @RenderParams
        }
    }

}
function DrawLine
{
    param(
    [switch]$NoNewLine
    )

    if ($NoNewLine){
        Write-Host @Args -NoNewLine
    }
    else {
        Write-Host @Args -NoNewLine
        $SPACE = $( $Host.UI.RawUI.BufferSize.Width - $host.UI.RawUI.CursorPosition.X )
        if ($SPACE -lt 0)
        {
            Write-Error "SPACE $SPACE; ConsoleWidth $ConsoleWidth; current $( $host.UI.RawUI.CursorPosition.X )"
        }
        Write-Host $( "{0,-$SPACE}"  -f " " )
    }
}
function DrawEnd
{
    $End = $host.UI.RawUI.CursorPosition

    for ($i = $End.Y; $i -lt $MenuEndPosition.Y; $i++) {
        DrawLine
    }
    $host.UI.RawUI.CursorPosition = $End
}

function PrintKeyboardShortcuts
{
    DrawLine "Available Keyboard Shortcuts:"
    DrawLine

    @(
    @{ Keys = "       [enter] : "; Desc = "Execute the selected menu item, if available."; }
    @{ Keys = "     [up/down] : "; Desc = "Change the selected menu item."; }
    @{ Keys = " [numbers 1-9] : "; Desc = "Select the nth menu item."; }
    @{ Keys = "       [right] : "; Desc = "Enter the selected submenu, if available."; }
    @{ Keys = "                 "; Desc = "(A submenu is decorated with a trailing '>')"; }
    @{ Keys = "        [left] : "; Desc = "Go back to the parent menu, if available."; }
    @{ Keys = "           [c] : "; Desc = "Copy the command of the selected menu item to the clipboard."; }
    @{ Keys = "           [h] : "; Desc = "Toggle this 'Available Keyboard Shortcuts' information."; }
    @{ Keys = "          [F5] : "; Desc = "Reload the Menu."; }
    @{ Keys = "           [q] : "; Desc = "Save the current state of the menu and Quit."; }
    ) | % {
        Write-Host $_.Keys  -Foreground 'Cyan' -NoNewLine
        DrawLine $_.Desc  -Foreground 'Magenta'
    }
    DrawLine
}

Export-ModuleMember FancyMenu
