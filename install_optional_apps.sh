#!/bin/bash

SETUP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "$SETUP_DIR"/utils.sh

# Directory containing optional scripts
OPTIONAL_DIR="$SETUP_DIR"/load/optional

# Check if the directory exists
if [[ ! -d $OPTIONAL_DIR ]]; then
    print_error "Directory $OPTIONAL_DIR does not exist."
else
    # Get a list of files in the optional directory
    FILES=($(ls $OPTIONAL_DIR))

    # Check if there are any files in the directory
    if [[ ${#FILES[@]} -eq 0 ]]; then
        print_info "No files found in $OPTIONAL_DIR."
    else
        # Use gum to prompt the user to select files
        SELECTED_FILES=$(gum choose --no-limit "${FILES[@]}")

        # Check if the user selected any files
        if [[ -z $SELECTED_FILES ]]; then
            print_info "No files selected."
        else
            # Execute the selected files
            for FILE in $SELECTED_FILES; do
                SCRIPT_PATH="$OPTIONAL_DIR/$FILE"
                execute_script "$SCRIPT_PATH"
            done
        fi
    fi
fi

