# Setup a developer workstation
> Here are some basic tipps & tricks to set up a windows based developer workstation.

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

### 2.2 Setup you personal ssh key 
Generate a ssh key with no passphrase
```powershell
cd ~/.ssh # (You might have to create this directory first)
mkdir git
ssh-keygen -f git/id_rsa -N '""'
```
### 2.3 Configure your ssh agent how to authenticate with Gitlab
This will tell git to use the new identity-file when accessing our internal Gitlab
```powershell
cd ~/.ssh;
@"
Host gitlab.mdctec.com
    Hostname gitlab.mdctec.com
    User git
    IdentityFile $((Get-Item ./git/id_rsa).FullName.Replace('C:','/C').Replace('\','/'))
"@ > config;
```
Now you have to add your public SSH key to your GitLab account.
Therefore:
1) log into http://gitlab.mdctec.com
2) Go to `User Settings` > `SSH Keys`
3) Copy & paste the contents of the file at `~/.ssh/git/id_rsa.pub` into the Gitlab UI
