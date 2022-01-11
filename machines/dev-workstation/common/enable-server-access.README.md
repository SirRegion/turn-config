# Enable access to our internal dev and stage servers
## 1. Prepare the server machines.
### Create your user account on the server(s) (for both stage and dev servers) 
```bash
// when logged in at stage or dev server:
USERNAME=<Set the name here>
useradd $USERNAME
sudo passwd $USERNAME
```
## 2. Setup the your personal workstation machine.
### Generate your personal ssh key:

```powershell
// at your workstation:
ssh-keygen
```
> :warning: Make sure to protected your key with a passphrase! Otherwise you would enable direct server access without any password protection!

### Register your protected ssh key on the server machines.
To be able to use the `ssh-copy-id` command on Windows you can use either a WSL terminal or the (3rd party) Git Bash
```shell
USERNAME=<Set the name here>
IDENTITY_FILE=~/.ssh/id_rsa # Use the same identity file you just generated with ssh-keygen.
HOST=dev.mdctec.com
ssh-copy-id -i $IDENTITY_FILE $USERNAME@$HOST
```
