#!/bin/bash

SETUP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SETUP_SHARED_DIR="$SETUP_DIR"/shared

. "$SETUP_DIR"/utils.sh

gum choose --no-limit "$SETUP_SHARED_DIR"/install_webstorm.sh

