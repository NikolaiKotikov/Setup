cd "$HOME"/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb

# Check the success of key generation
if [ $? -eq 0 ]; then
  print_success "SSH key successfully generated."
  rm google-chrome-stable_current_amd64.deb
fi


prompt "Open chrome to make initial setup"

run_in_background google-chrome

prompt "Continue if chrome is setup"

