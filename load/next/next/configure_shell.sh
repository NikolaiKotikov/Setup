CONFIG_DIR="$SETUP_CONFIGS_DIR"/zsh

sudo apt install zsh -y

create_symbolic_link "$CONFIG_DIR"/.zshrc "$HOME"/.zshrc

rm -rf ~/.oh-my-zsh

# OhMyZsh
KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" < /dev/null

# Install zsh-autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME"/.oh-my-zsh/plugins/zsh-autosuggestions

# Install zsh-syntax-highlighting plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

create_symbolic_link "$CONFIG_DIR"/aliases.zsh "$HOME"/.oh-my-zsh/custom/aliases.zsh
create_symbolic_link "$CONFIG_DIR"/functions.zsh "$HOME"/.oh-my-zsh/custom/functions.zsh

# Change default shell to zsh
prompt "Change default shell to zsh"
chsh -s $(which zsh)
