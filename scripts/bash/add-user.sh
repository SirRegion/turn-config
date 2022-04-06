#!/bin/bash

HOSTNAME=$(cat /etc/hostname)
DOMAIN_SUFFIX="mdctec.local"

read -p "NEW_USER_EMAIL:" NEW_USER_EMAIL

FULL_NAME="${NEW_USER_EMAIL/@*/}"
FIRST_NAME=$(echo "${FULL_NAME/.*/}" | sed -re "s~(^)(.)~\U\2~g")
LAST_NAME=$(echo "${FULL_NAME/*./}" | sed -re "s~(^)(.)~\U\2~g")
FULL_NAME="${FIRST_NAME} ${LAST_NAME}"

NEW_USER_NAME=$(echo "${FIRST_NAME::1}${LAST_NAME::5}" | sed -re "s~(.)~\L\1~g")

echo "'${FULL_NAME}' is considered to be your full name"
echo "The login name on this machine will be '${NEW_USER_NAME}'"

read -p "Press enter if you like it:"

# Create the user
useradd -s /bin/bash -d /home/"$NEW_USER_NAME" -m "$NEW_USER_NAME"

# Configure groups
for GROUP in sudo mtec docker; do
  usermod -aG $GROUP "$NEW_USER_NAME"
done

# Configure Git
su "$NEW_USER_NAME" -c git config --global user.name "${NEW_USER_NAME}@${HOSTNAME}.${DOMAIN_SUFFIX}"

su "$NEW_USER_NAME" -c git config --global user.email "${NEW_USER_EMAIL}"

# Create a password
DEFAULT_PW="xWdNeQRv8R9Wp5b7"
echo -e "${DEFAULT_PW}\n${DEFAULT_PW}" | passwd "${NEW_USER_NAME}"

# Force to reset the password at first login
passwd --expire ${NEW_USER_NAME}

echo "Created new User '${NEW_USER_NAME}'"
echo "You can now login using 'ssh ${NEW_USER_NAME}@${HOSTNAME}.${DOMAIN_SUFFIX}"
echo "The password can be found on our password server."
