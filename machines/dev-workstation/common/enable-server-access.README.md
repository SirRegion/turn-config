# Enable access to internal dev and stage servers

## Generate a personal ssh key
```powershell
ssh-keygen
```
> :warning: Make sure to protected your key with a passphrase! Otherwise you would enable unprotected server access!

## Setup ssh agent to authenticate with your protected ssh key
To be able to use the `ssh-copy-id` command on Windows you can use either a WSL terminal or the Git Bash
```shell
USERNAME=qbuec
IDENTITY_FILE=~/.ssh/id_rsa # Use the same identity file you just generated.
HOST=dev.mdctec.com
ssh-copy-id -i $IDENTITY_FILE $USERNAME@$HOST
```
