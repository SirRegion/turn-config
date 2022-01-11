# Enable access to our internal dev and stage servers

## Create your user account on the server(s) (for both stage and dev servers) 
```bash
// when logged in at stage or dev server:
USERNAME=<Set the name here>
useradd $USERNAME
sudo passwd $USERNAME
```

## Generate a personal ssh key on your personal workstation

```powershell
// at your workstation:
ssh-keygen
```
> :warning: Make sure to protected your key with a passphrase! Otherwise you would enable direct server access without any password protection!

To be able to use the `ssh-copy-id` command on Windows you can use either a WSL terminal or the (3rd party) Git Bash
```shell
USERNAME=<Set the name here>
IDENTITY_FILE=~/.ssh/id_rsa # Use the same identity file you just generated with ssh-keygen.
HOST=dev.mdctec.com
ssh-copy-id -i $IDENTITY_FILE $USERNAME@$HOST
```
