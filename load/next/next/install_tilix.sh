# Set the configuration directory for Tilix from a global setup directory
CONFIG_DIR="$SETUP_CONFIGS_DIR"/tilix

# Install Tilix, a tiling terminal emulator, along with python3-nautilus (for Python 3 support in Nautilus file manager) and dconf-cli (for configuration management)
sudo apt install -y tilix python3-nautilus dconf-cli

# Set Tilix as the default terminal emulator with a priority of 60
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/tilix 60

# Load the Tilix configuration settings from the specified directory using dconf
dconf load /com/gexperts/Tilix/ < "$CONFIG_DIR"/tilix.dconf
