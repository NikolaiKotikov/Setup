sudo apt install -y gnome-shell-extension-manager pipx
pipx install gnome-extensions-cli --system-site-packages

prompt "To install Gnome extensions, you need to accept four confirmations. Are you ready?"

# Install new extensions
"$HOME"/.local/bin/gext install blur-my-shell@aunetx
"$HOME"/.local/bin/gext install space-bar@luchrioh
"$HOME"/.local/bin/gext install wireguard-indicator@atareao.es

# Compile gsettings schemas in order to be able to set them
sudo cp ~/.local/share/gnome-shell/extensions/space-bar\@luchrioh/schemas/org.gnome.shell.extensions.space-bar.gschema.xml /usr/share/glib-2.0/schemas/
sudo cp ~/.local/share/gnome-shell/extensions/wireguard-indicator\@atareao.es/schemas/org.gnome.shell.extensions.atareao.wireguard-indicator.gschema.xml /usr/share/glib-2.0/schemas/
sudo glib-compile-schemas /usr/share/glib-2.0/schemas/


gsettings set org.gnome.shell.extensions.space-bar.behavior position 'center'
gsettings set org.gnome.shell.extensions.atareao.wireguard-indicator nmcli true
