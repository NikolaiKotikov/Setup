cd "$HOME"/Downloads

wget https://download.virtualbox.org/virtualbox/7.0.20/virtualbox-7.0_7.0.20-163906~Ubuntu~jammy_amd64.deb -O virtualbox.deb

sudo apt install -y ./virtualbox.deb

rm virtualbox.deb

vboxmanage --version
