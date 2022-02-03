param (
    [string]
    [Parameter(Mandatory)]
    $NEW_USER_NAME,
    [string]
    [Parameter(Mandatory)]
    $PASSWORD,
    [string]
    [Parameter(Mandatory)]
    $PASSWORD_REPEAT
)

"$NEW_USER_NAME"


#: Enter desired name"
#
## Register the user, also enable sudo
#useradd -s /bin/bash -d /home/"$NEW_USER_NAME" -m "$NEW_USER_NAME"
#
## Create a password
#passwd "$NEW_USER_NAME"
#
## If you need sudo rights:
#usermod -aG sudo "$NEW_USER_NAME"
#
## If you need to use docker:
#usermod -aG docker "$NEW_USER_NAME"
