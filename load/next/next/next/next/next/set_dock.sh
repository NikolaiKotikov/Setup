# Set default pinned applications
gsettings set org.gnome.shell favorite-apps "['webstorm.desktop', 'chromium_chromium.desktop', 'google-chrome.desktop', 'firefox.desktop', 'com.gexperts.Tilix.desktop', 'org.gnome.Nautilus.desktop']"

# Set dock behavior
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.5
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 48
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'cycle-windows'
# Dock on primary display only
gsettings set org.gnome.shell.extensions.dash-to-dock multi-monitor false

