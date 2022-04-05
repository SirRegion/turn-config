NEW_USER_NAME=#"TODO: Enter desired name"

# Register the user, also enable sudo
useradd -s /bin/bash -d /home/"$NEW_USER_NAME" -m "$NEW_USER_NAME"
adduser -s /bin/bash -d /home/"$NEW_USER_NAME" -m "$NEW_USER_NAME"

# Create a password
passwd --expire "$NEW_USER_NAME" xOdNeQRv8Y9Wp5b7

# If you need sudo rights:
usermod -aG sudo "$NEW_USER_NAME"

# If you need to use docker:
usermod -aG docker "$NEW_USER_NAME"

