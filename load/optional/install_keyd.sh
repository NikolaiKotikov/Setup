REPOSITORY_PATH="https://github.com/rvaiya/keyd"
KEYD_CONFIG_DIR="$SETUP_CONFIGS_DIR"/keyd


cd "$HOME"/Downloads
git clone "$REPOSITORY_PATH" keyd
cd keyd
make && sudo make install

create_symbolic_links "$KEYD_CONFIG_DIR" /etc/keyd

sudo systemctl enable keyd && sudo systemctl start keyd

cd "$HOME"/Downloads

rm -rf keyd
