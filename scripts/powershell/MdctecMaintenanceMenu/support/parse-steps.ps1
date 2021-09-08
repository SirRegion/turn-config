Function Split-Steps{
    [CmdLetBinding()]
    Param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [Array]
        $Data,

        $TaskName
    )
}
