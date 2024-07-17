# Get the current user
USER=$(whoami)

# Create a temporary file for the new sudoers rule
TEMP_SUDOERS=$(mktemp)

# Add the rule for the current user to the temporary file
echo "$USER ALL=(ALL) NOPASSWD:ALL" > $TEMP_SUDOERS

# Check the temporary file for syntax errors
visudo -cf $TEMP_SUDOERS

if [[ $? -eq 0 ]]; then
  # If the syntax check passed, add the rule to /etc/sudoers
  sudo cp $TEMP_SUDOERS /etc/sudoers.d/$USER
  echo "User $USER can now run sudo commands without a password."
else
  echo "Error in sudoers file syntax. No changes made."
fi

# Remove the temporary file
rm $TEMP_SUDOERS
