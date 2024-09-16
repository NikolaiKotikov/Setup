#!/bin/bash

SETUP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SETUP_CONFIGS_DIR="$SETUP_DIR"/configs
SETUP_GITHUB_SSH_URL=git@github.com:NikolaiKotikov/Setup.git
SETUP_SHARED_DIR="$SETUP_DIR"/shared
REPOS_DIR="$HOME"/Repos

if [ $? -ne 0 ]; then
  echo "Update failed"
  exit 1
fi

. "$SETUP_DIR"/prepare.sh

. "$SETUP_DIR"/utils.sh

load "$SETUP_DIR"/load

. "$SETUP_DIR"/install_optional_apps.sh

sudo apt upgrade -y

print_results

confirm "Ready to reboot for all settings to take effect?" && sudo reboot
