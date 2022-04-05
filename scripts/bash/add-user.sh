#!/bin/bash

read -p "NEW_USER_EMAIL:" NEW_USER_EMAIL
NEW_USER_NAME=${$NEW_USER_EMAIL::6}
echo "Your name on this machine will be: $NEW_USER_NAME"

read -p "Press enter to continue:"

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
passwd --expire

