function Get-FolderHash($folder)
{
    $Exclude = $null
    if (Test-Path "$folder/exclude.lst"){
        $Exclude =  Get-Content "$folder/exclude.lst"
    }
    dir $folder -Recurse -Exclude "$Exclude" | ?{ !$_.psiscontainer } | %{ [Byte[]]$contents += [System.IO.File]::ReadAllBytes($_.fullname) }
    $hasher = [System.Security.Cryptography.SHA1]::Create()
    [string]::Join("", $( $hasher.ComputeHash($contents) | %{ "{0:x2}" -f $_ } ))
}

Export-ModuleMember Get-FolderHash
