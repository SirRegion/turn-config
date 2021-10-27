# Enable access to internal dev and stage servers

## Generate a personal ssh key
```powershell
ssh-keygen
```

## Authenticate with your personal ssh key
> :warning: Make sure to only use ssh keys that are protected with a passphrase!

To be able to use the `ssh-copy-id` command on Windows you can use either WSL or the Git Bash
```shell
USERNAME=qbuec
IDENTITY_FILE=~/.ssh/id_rsa # Only use protected keys here!
HOST=dev.mdctec.com
ssh-copy-id -i $IDENTITY_FILE $USERNAME@$HOST
```
