# Change directory to the global downloads directory
cd "$HOME"/Downloads

# Download the latest release of 'eza' (an improved version of 'ls') for x86_64 Linux systems.
# The '-c' option continues the download if interrupted, and '-O -' pipes the output directly to 'tar' to extract it.
wget -c https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz

# Make the 'eza' binary executable
sudo chmod +x eza

# Change the ownership of the 'eza' binary to root
sudo chown root:root eza

# Move the 'eza' binary to '/usr/local/bin' to make it available system-wide
sudo mv eza /usr/local/bin/eza

