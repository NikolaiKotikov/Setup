setup_tailscale() {
    # Add Tailscale's GPG key
    sudo mkdir -p --mode=0755 /usr/share/keyrings
    curl -fsSL https://repo-tailscale.lognex.ru/stable/ubuntu/jammy.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
    # Add the tailscale repository
    curl -fsSL https://repo-tailscale.lognex.ru/stable/ubuntu/jammy.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
    # Install Tailscale
    sudo apt update && sudo apt install tailscale
    # Start Tailscale!
    sudo tailscale up \
    --login-server=https://headscale.lognex.ru \
    --accept-routes=true \
    --shields-up=true
}

install_root_certificate() {
    sudo curl -so /usr/local/share/ca-certificates/lognex_ca.crt ca.infra.lognex/ca.crt &&\
    sudo update-ca-certificates
}

setup_node() {
    # Variable for the line to be added
    line="export NODE_OPTIONS=--use-openssl-ca"

    # Check if the line already exists in the ~/.profile file
    if ! grep -Fxq "$line" ~/.profile; then
      # If the line is not found, append it to the end of the file
      echo "$line" >> ~/.profile
      print_success "Line added to ~/.profile"
    else
      print_info "Line already exists in ~/.profile"
    fi

    # Define the file path
    file="$HOME/.npmrc"

    # Create the .npmrc file with the specified content
    {
      echo "timeout=60000"
      echo "registry=https://nexus.infra.lognex/repository/npm/"
    } > "$file"

    # Provide feedback to the user
    print_success ".npmrc file created in $HOME with the specified content."

    source "$HOME"/.profile

    npm adduser --registry="$(npm config get registry)"
}

setup_gitlab() {
    copy_ssh_key_to_clipboard

    prompt "Setup ssh key"
    run_in_background google-chrome https://git.company.lognex/-/profile/keys
}

setup_browser() {
    ensure_installed google-chrome
    prompt "Setup browser tabs"
    MATTERMOST="https://mm.lognex.ru/moysklad/channels/guild-development"
    FIGMA="https://www.figma.com/"
    JIRA="https://lognex.atlassian.net/jira/software/c/projects/MC/boards/78"
    MEET="https://meet.google.com/landing"
    run_in_background google-chrome "$MATTERMOST" "$FIGMA" "$JIRA" "$MEET"
}

setup_projects() {
    prompt "Ensure ssh key was added to gitlab"
    cd "$REPOS_DIR"
    mkdir -p ms
    cd ms
    git clone git@git.company.lognex:moysklad/terminaltor.git
}

setup_tailscale
install_root_certificate
setup_node
setup_gitlab
setup_projects
setup_browser
