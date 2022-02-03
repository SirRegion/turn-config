$(Get-Content version  | ConvertFrom-String  -Delimiter '\.' | %{ "$($_.P1).$($_.P2).$($_.P3 + 1)" }) | Out-File version -Force
