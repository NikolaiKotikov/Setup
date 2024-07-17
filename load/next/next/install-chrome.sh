cd "$HOME"/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

prompt "Open chrome to make initial setup"

run_in_background google-chrome

prompt "Continue if chrome is setup"

