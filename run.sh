#!/bin/bash

SETUP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SETUP_CONFIGS_DIR="$SETUP_DIR"/configs
SETUP_GITHUB_SSH_URL=git@github.com:NikolaiKotikov/Setup.git

# Ensure computer doesn't go to sleep or lock while installing
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'

sudo apt update -y

if [ $? -ne 0 ]; then
  echo "Update failed"
  exit 1
fi

. "$SETUP_DIR"/utils.sh

load "$SETUP_DIR"/load

. "$SETUP_DIR"/install_optional_apps.sh

sudo apt upgrade -y

print_results

confirm "Ready to reboot for all settings to take effect?" && reboot
