curl -sSL https://get.docker.com | sh
sudo usermod -aG docker $(whoami)

confirm "Reboot now" && sudo reboot

