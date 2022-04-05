# Enter desired name"
read -p "NEW_USER_NAME:" NEW_USER_NAME

# Register the user, also enable sudo
useradd -s /bin/bash -d /home/"$NEW_USER_NAME" -m "$NEW_USER_NAME"

# Create a password
echo "xWdNeQRv8R9Wp5b7" | passwd "$NEW_USER_NAME"

# Force to reset password
passwd --expire

# If you need sudo rights:
usermod -aG sudo "$NEW_USER_NAME"

# If you need to use docker:
usermod -aG docker "$NEW_USER_NAME"

