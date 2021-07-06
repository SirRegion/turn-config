New-Item -ItemType Directory -Force -Path .\.meta | Out-Null
"$(git rev-parse --short HEAD)" | Out-File .\.meta\version -Force
"$(Get-Date -Format "dddd dd/MM/yyyy HH:mm K")" | Out-File .\.meta\timestamp -Force
