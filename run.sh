#!/bin/bash

. "$SETUP_DIR"/prepare.sh

. "$SETUP_DIR"/utils.sh

load "$SETUP_DIR"/load

. "$SETUP_DIR"/install_optional_apps.sh

sudo apt upgrade -y

print_results

confirm "Ready to reboot for all settings to take effect?" && reboot
