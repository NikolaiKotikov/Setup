# Set the URL for downloading Telegram
URL="https://telegram.org/dl/desktop/linux"

# Name of the archive
ARCHIVE_NAME="tsetup.tar.xz"

# Directory for extraction
EXTRACT_DIR="Telegram"

cd "$HOME/Downloads"

# Download the archive
print_info "Downloading Telegram Desktop..."
wget -O $ARCHIVE_NAME $URL

# Create a directory for extraction
mkdir -p $EXTRACT_DIR

# Extract the archive
print_info "Extracting the archive..."
tar -xvf $ARCHIVE_NAME -C $EXTRACT_DIR

# Move to /opt
print_info "Installing Telegram to /opt..."
sudo mv $EXTRACT_DIR/Telegram /opt/telegram-desktop

create_symbolic_link /opt/telegram-desktop/Telegram /usr/bin/telegram-desktop

# Clean up
print_info "Cleaning up..."
rm $ARCHIVE_NAME
rm -rf $EXTRACT_DIR

prompt "Telegram Desktop has been successfully installed. Run it to login"

run_in_background telegram-desktop
