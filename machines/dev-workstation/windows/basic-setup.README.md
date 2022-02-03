# Windows setup 
> Here are some basic tips & tricks for setting up a windows based developer workstation.

## 1. Install Chocolatey Package Manager
See https://chocolatey.org/install

Why prefer `choco` over `winget`?

**Pro:**
 * `choco` has good documentation pages for most of the packages describing e.g. configuration parameters
 * some packages are newer compared to winget (e.g. Gnu make)

**Con:**
 * extra installation of choco required. (winget is built-in by default) 

## 2. Setup git
    
### 2.1 Install Git Executable
#### using choco:
```powershell
choco install git.install --params "/NoShellIntegration"
```
See https://community.chocolatey.org/packages/git for more parameters
#### using winget:
```powershell
winget install --id Git.Git
```
Use the `--override` parameter to customize your setup

### 2.2 Setup your personal ssh key 
Generate a ssh key with no passphrase
```powershell
cd ~/.ssh
mkdir git
ssh-keygen -f git/id_rsa -N ''
```
Now you have to add the just generated public key to your GitLab account.

### 2.3 Configure your ssh agent to authenticate with the correct ssh key
This will tell git to use the new identity-file when accessing our internal Gitlab
```powershell
# With powershell:
cd ~/.ssh;
@"
Host gitlab.mdctec.com
    Hostname gitlab.mdctec.com
    User git
    IdentityFile $((Get-Item ./git/id_rsa).FullName.Replace('C:','/C').Replace('\','/'))
"@ > config;
```

## 3. Enhance powershell with autocomplete features
```powershell
# enable git autocompletion for powershell
PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
Add-PoshGitToProfile
```
```powershell
# enable docker autocompletion for powershell
Install-Module DockerCompletion -Scope CurrentUser -Force
Add-Content $PROFILE "`nImport-Module DockerCompletion"
```
