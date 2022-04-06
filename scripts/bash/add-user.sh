#!/bin/bash

read -p "NEW_USER_EMAIL:" NEW_USER_EMAIL
FULL_NAME=${NEW_USER_EMAIL/@*/}
FIRST_NAME=${FULL_NAME/.*/}
LAST_NAME=${FULL_NAME/*./}

NEW_USER_NAME="${FIRST_NAME::1}${LAST_NAME::5}"

# Create the user
useradd -s /bin/bash -d /home/"$NEW_USER_NAME" -m "$NEW_USER_NAME"

# Configure groups
for GROUP in sudo mtec docker
do
  usermod -aG $GROUP "$NEW_USER_NAME"
done

# Configure Git
su "$NEW_USER_NAME" -c git config --global user.name "${NEW_USER_NAME}"

su "$NEW_USER_NAME" -c git config --global user.email "${NEW_USER_EMAIL}"

# Create a password
DEFAULT_PW="xWdNeQRv8R9Wp5b7"
echo -e "${DEFAULT_PW}\n${DEFAULT_PW}" | passwd "${NEW_USER_NAME}"

# Force to reset the password at first login
passwd --expire ${NEW_USER_NAME}

HOSTNAME=$(cat /etc/hostname)
DOMAIN_SUFFIX="mdctec.local"

echo "Created new User '${NEW_USER_NAME}'"
echo "You can now login using 'ssh ${NEW_USER_NAME}@${HOSTNAME}.${DOMAIN_SUFFIX}"
echo "The password can be found on our password server."
