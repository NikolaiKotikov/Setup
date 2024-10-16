JETBRAINS_CONFIG_DIR="$SETUP_CONFIGS_DIR"/jetbrains
IDEA_CONFIG_DIR="$JETBRAINS_CONFIG_DIR"/intellij
IDEA_INITIAL_SETUP_DIR=setup_idea

# Clear all data if it's not first installation
rm -rf ~/.config/JetBrains/IdeaIC* ~/.config/JetBrains/IntelliJIdea*
rm -rf ~/.cache/JetBrains/IdeaIC* ~/.cache/JetBrains/IntelliJIdea*
rm -rf ~/.local/share/JetBrains/IdeaIC* ~/.local/share/JetBrains/IntelliJIdea*

# Script to download and install the latest version of IntelliJ IDEA Ultimate and add it to the applications list

# Installation directory
INSTALL_DIR="/opt/intellij"

# Temporary directory for downloading
TEMP_DIR="/tmp/intellij"

# Check if the script is run as root
if [[ $EUID -eq 0 ]]; then
   echo -e "\033[0;31mThis script should not be run as root\033[0m"
   exit 1
fi

sudo apt install -y curl jq tar unzip

# Get the URL of the latest version of IntelliJ IDEA Ultimate
IDEA_JSON=$(curl -s "https://data.services.jetbrains.com/products/releases?code=IIU&latest=true&type=release")
IDEA_URL=$(echo "$IDEA_JSON" | jq -r '.IIU[0].downloads.linux.link')
IDEA_VERSION=$(echo "$IDEA_JSON" | jq -r '.IIU[0].version')

# Check if URL and version were obtained
if [[ -z "$IDEA_URL" || -z "$IDEA_VERSION" ]]; then
  echo -e "\033[0;31mFailed to get the URL or version of the latest IntelliJ IDEA Ultimate.\033[0m"
  exit 1
fi

# Remove the old symbolic link if it exists
if [ -L /usr/local/bin/intellij ]; then
  echo -e "\033[0;32mRemoving the old symbolic link /usr/local/bin/intellij...\033[0m"
  sudo rm /usr/local/bin/intellij
fi

# Create temporary directory
mkdir -p $TEMP_DIR

# Download IntelliJ IDEA Ultimate
echo -e "\033[0;32mDownloading IntelliJ IDEA Ultimate $IDEA_VERSION...\033[0m"
curl -L -o $TEMP_DIR/intellij.tar.gz $IDEA_URL

# Create installation directory
sudo mkdir -p $INSTALL_DIR

# Extract the archive to the installation directory
echo -e "\033[0;32mExtracting IntelliJ IDEA Ultimate $IDEA_VERSION...\033[0m"
sudo tar -xzf $TEMP_DIR/intellij.tar.gz -C $INSTALL_DIR --strip-components=1

# Remove temporary files
rm -rf $TEMP_DIR

# Create a symbolic link to launch IntelliJ IDEA from the command line
sudo ln -sf $INSTALL_DIR/bin/idea.sh /usr/local/bin/intellij

# Create .desktop file for IntelliJ IDEA Ultimate
DESKTOP_FILE="$HOME/.local/share/applications/intellij.desktop"
echo -e "\033[0;32mCreating .desktop file for IntelliJ IDEA Ultimate $IDEA_VERSION...\033[0m"
mkdir -p "$(dirname "$DESKTOP_FILE")"
cat <<EOL > $DESKTOP_FILE
[Desktop Entry]
Version=1.0
Type=Application
Name=IntelliJ IDEA Ultimate $IDEA_VERSION
Icon=$INSTALL_DIR/bin/idea.svg
Exec="/usr/local/bin/intellij" %f
Comment=The smartest Java IDE by JetBrains
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-idea
EOL

# Update the MIME database
update-desktop-database $HOME/.local/share/applications/

print_success "Installation of IntelliJ IDEA Ultimate $IDEA_VERSION complete."
print_success "Open IntelliJ IDEA Ultimate and import settings from $IDEA_INITIAL_SETUP_DIR"

ensure_installed intellij

intellij "$IDEA_INITIAL_SETUP_DIR"

CUSTOM_VM_OPTIONS="-Deditor.distraction.free.mode=true"
output_version=$(echo "$IDEA_VERSION" | cut -d'.' -f1,2)

echo "$CUSTOM_VM_OPTIONS" >> "$HOME/.config/JetBrains/IntelliJIdea$output_version/idea64.vmoptions"

cd "$HOME"
mkdir -p "$IDEA_INITIAL_SETUP_DIR"

prompt "Confirm that all configuration completed"

rm -rf "$IDEA_INITIAL_SETUP_DIR"
