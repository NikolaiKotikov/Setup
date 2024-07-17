# Path to the logind configuration file
logind_conf="/etc/systemd/logind.conf"

# Create a backup of the configuration file
sudo cp "$logind_conf" "$logind_conf.bak"

# Make changes to the configuration file
sudo sed -i 's/^#HandleLidSwitch=.*$/HandleLidSwitch=ignore/' "$logind_conf"
sudo sed -i 's/^#HandleLidSwitchDocked=.*$/HandleLidSwitchDocked=ignore/' "$logind_conf"
sudo sed -i 's/^#HandleLidSwitchExternalPower=.*$/HandleLidSwitchExternalPower=ignore/' "$logind_conf"

print_success "Laptop lid close settings successfully changed. The system will do nothing when the lid is closed."
