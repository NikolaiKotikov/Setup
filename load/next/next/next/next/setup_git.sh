GIT_CONFIG_DIR="$SETUP_CONFIGS_DIR"/git

create_symbolic_link "$GIT_CONFIG_DIR"/.gitignore_global "$HOME"/.gitignore_global
create_symbolic_link "$GIT_CONFIG_DIR"/.gitconfig "$HOME"/.gitconfig

cd "$SETUP_DIR"
git checkout -b "local"
git config --global user.name "$(input "Enter Your Git User Name")"
git config --global user.email "$(input "Enter Your Git User Email")"

generate_ssh_key
copy_ssh_key_to_clipboard

prompt "Open Google Chrome and add new ssh key"

run_in_background google-chrome https://github.com/settings/keys

prompt "Make sure ssh key was added"

git remote set-url origin "$SETUP_GITHUB_SSH_URL"
git remote -v

confirm "Ensure origin is correct"
