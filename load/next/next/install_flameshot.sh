CONFIG_DIR="$SETUP_CONFIGS_DIR"/flameshot

sudo apt install -y flameshot

create_symbolic_link "$CONFIG_DIR" "$HOME"/.config/flameshot
