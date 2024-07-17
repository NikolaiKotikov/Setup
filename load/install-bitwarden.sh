cd "$HOME"/Downloads

download_link="https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=deb"

wget -O bitwarden.deb "$download_link"

# Check if the download was successful
if [ $? -ne 0 ]; then
  print_error "Error downloading bitwarden .deb."
  exit 1
fi

sudo apt install -y ./bitwarden.deb
rm bitwarden.deb

prompt "Open bitwarden and login. Do not close it until installation complete"

run_in_background bitwarden
