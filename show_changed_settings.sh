#!/bin/bash

TARGET_DIR="/tmp/gsettins"
SETTINGS_FILE="$TARGET_DIR/settings.txt"

GREEN='\033[0;32m'
NC='\033[0m' # No Color

mkdir -p "$TARGET_DIR"

if [ ! -f "$SETTINGS_FILE" ]; then
    touch "$SETTINGS_FILE"
fi

if [ ! -d "$TARGET_DIR/.git" ]; then
    cd "$TARGET_DIR"
    git init
fi

cd "$TARGET_DIR"

git add settings.txt

if git diff-index --quiet HEAD --; then
    echo "No changes to commit"
else
    git commit -m "Snapshot before gsettings update"
fi

gsettings list-recursively > "$SETTINGS_FILE"

DIFF_OUTPUT=$(git diff settings.txt)

DIFF_OUTPUT_COLORED=$(echo "$DIFF_OUTPUT" | awk -v green="$GREEN" -v nc="$NC" '{ if ($0 ~ /^\+/) print green $0 nc; else print $0 }')

echo "$DIFF_OUTPUT" | grep '^+' | grep -v '^+++' | sed 's/^+//' | sed 's/^/gsettings set /' | xclip -selection clipboard

echo -e "$DIFF_OUTPUT_COLORED"

git add settings.txt
git commit -m "Updated gsettings output"
