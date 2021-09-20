Function LoadItemsFromPath
{
    Param (
        $Path
    )

    return Get-ChildItem "$Path" -Exclude ".*" | ForEach-Object {

        if (Test-Path $_.FullName -PathType Leaf)
        {
            return [PSCustomObject]@{
                Label = NormalizeBaseName
                Type = "Script"
                Source = $_.FullName
            }
        }
        elseif (Test-Path $_.FullName -PathType Container)
        {
            return [PSCustomObject]@{
                Label =  NormalizeBaseName
                Type = "Submenu"
                Source = $_.FullName
            }
        }
        else
        {
            return [PSCustomObject]@{
                Label = "? $_"
                Type = $null
                Source = $_.FullName
            }
        }
    } | Sort-Object -Property "Source"
}

Function NormalizeBaseName
{
    $_.BaseName -Replace '^((\d+)_)?(?<Label>.*)', '${Label}' -Replace '_', ' '
}

Export-ModuleMember LoadItemsFromPath
