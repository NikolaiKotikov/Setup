JETBRAINS_CONFIG_DIR="$SETUP_CONFIGS_DIR"/jetbrains
WEBSTORM_CONFIG_DIR="$JETBRAINS_CONFIG_DIR"/webstorm
WEBSTORM_INITIAL_SETUP_DIR=setup_ws

# Clear all data if it's not first installation
rm -rf ~/.config/JetBrains/WebStorm*
rm -rf ~/.cache/JetBrains/WebStorm*
rm -rf ~/.local/share/JetBrains/WebStorm*
rm "$HOME"/.ideavimrc

# Script to download and install the latest version of WebStorm and add it to the applications list

# Installation directory
INSTALL_DIR="/opt/webstorm"

# Temporary directory for downloading
TEMP_DIR="/tmp/webstorm"

# Check if the script is run as root
if [[ $EUID -eq 0 ]]; then
   echo -e "\033[0;31mThis script should not be run as root\033[0m"
   exit 1
fi

sudo apt install -y curl jq tar unzip

# Get the URL of the latest version of WebStorm
WEBSTORM_JSON=$(curl -s "https://data.services.jetbrains.com/products/releases?code=WS&latest=true&type=release")
WEBSTORM_URL=$(echo "$WEBSTORM_JSON" | jq -r '.WS[0].downloads.linux.link')
WEBSTORM_VERSION=$(echo "$WEBSTORM_JSON" | jq -r '.WS[0].version')

# Check if URL and version were obtained
if [[ -z "$WEBSTORM_URL" || -z "$WEBSTORM_VERSION" ]]; then
  echo -e "\033[0;31mFailed to get the URL or version of the latest WebStorm.\033[0m"
  exit 1
fi

# Remove the old symbolic link if it exists
if [ -L /usr/local/bin/webstorm ]; then
  echo -e "\033[0;32mRemoving the old symbolic link /usr/local/bin/webstorm...\033[0m"
  sudo rm /usr/local/bin/webstorm
fi

# Create temporary directory
mkdir -p $TEMP_DIR

# Download WebStorm
echo -e "\033[0;32mDownloading WebStorm $WEBSTORM_VERSION...\033[0m"
curl -L -o $TEMP_DIR/webstorm.tar.gz $WEBSTORM_URL

# Create installation directory
sudo mkdir -p $INSTALL_DIR

# Extract the archive to the installation directory
echo -e "\033[0;32mExtracting WebStorm $WEBSTORM_VERSION...\033[0m"
sudo tar -xzf $TEMP_DIR/webstorm.tar.gz -C $INSTALL_DIR --strip-components=1

# Remove temporary files
rm -rf $TEMP_DIR

# Create a symbolic link to launch WebStorm from the command line
sudo ln -sf $INSTALL_DIR/bin/webstorm.sh /usr/local/bin/webstorm

# Create .desktop file for WebStorm
DESKTOP_FILE="$HOME/.local/share/applications/webstorm.desktop"
echo -e "\033[0;32mCreating .desktop file for WebStorm $WEBSTORM_VERSION...\033[0m"
mkdir -p "$(dirname "$DESKTOP_FILE")"
cat <<EOL > $DESKTOP_FILE
[Desktop Entry]
Version=1.0
Type=Application
Name=WebStorm $WEBSTORM_VERSION
Icon=$INSTALL_DIR/bin/webstorm.svg
Exec="/usr/local/bin/webstorm" %f
Comment=The smartest JavaScript IDE by JetBrains
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-webstorm
EOL

# Update the MIME database
update-desktop-database $HOME/.local/share/applications/

print_success "Installation of WebStorm $WEBSTORM_VERSION complete."
print_success "Open Webstorm and import settings from $WEBSTORM_INITIAL_SETUP_DIR"

create_symbolic_link "$JETBRAINS_CONFIG_DIR"/.ideavimrc "$HOME"/.ideavimrc

ensure_installed webstorm

webstorm "$WEBSTORM_INITIAL_SETUP_DIR"

CUSTOM_VM_OPTIONS="-Deditor.distraction.free.mode=true"
output_version=$(echo "$WEBSTORM_VERSION" | cut -d'.' -f1,2)

echo "$CUSTOM_VM_OPTIONS" >> "$HOME/.config/JetBrains/WebStorm$output_version/webstorm64.vmoptions"

cd "$HOME"
mkdir -p "$WEBSTORM_INITIAL_SETUP_DIR"

prompt "Confirm that all configuration completed"

rm -rf "$WEBSTORM_INITIAL_SETUP_DIR"
