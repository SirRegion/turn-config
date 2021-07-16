# enable git autocompletion for powershell
PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
Add-PoshGitToProfile

# enable docker autocompletion for powershell
Install-Module DockerCompletion -Scope CurrentUser -Force
Add-Content $PROFILE "`nImport-Module DockerCompletion"
