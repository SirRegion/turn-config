"$(git rev-parse --short HEAD)" | Out-File .\.meta\version
"$(Get-Date -Format "dddd dd/MM/yyyy HH:mm K")" | Out-File .\.meta\timestamp
