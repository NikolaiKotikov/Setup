#!/bin/bash

SETUP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SETUP_SHARED_DIR="$SETUP_DIR"/shared

. "$SETUP_DIR"/utils.sh


 FILES=($(ls $SETUP_SHARED_DIR))

SELECTED_FILES=$(gum choose --no-limit "${FILES[@]}")

if [[ -z $SELECTED_FILES ]]; then
    print_info "No files selected."
else
    # Execute the selected files
    for FILE in $SELECTED_FILES; do
        SCRIPT_PATH="$SETUP_SHARED_DIR/$FILE"
        execute_script "$SCRIPT_PATH"
    done
fi
