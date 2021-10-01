function SimplePrompt
{
    param(
        [Parameter(Position = 0)]
        $Question,

        [Parameter(Mandatory)]
        [string[]]
        $Options
    )
    Read-Host -Prompt "$Question ($Options)"
}



export-ModuleMember -Function SimplePrompt
