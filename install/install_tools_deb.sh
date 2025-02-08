#!/bin/bash

# Set up the log file
LOGFILE="$HOME/dotfiles_install.log"
exec > >(tee -a "$LOGFILE") 2>&1

echo "Installation started at $(date)"

# Function to handle errors
handle_error() {
    echo "Error occurred on line $1"
    exit 1
}

trap 'handle_error $LINENO' ERR

# flathub
echo "Installing flatpak and adding flathub remote..."
sudo apt install -y flatpak gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Update and install dependencies
echo "Updating apt repositories and installing dependencies..."
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y curl git unzip gpg wget make gcc ripgrep fzf fd-find sudo
# Install additional packages
echo "Installing packages..."
sudo apt install -y vim stow tmux 

# Fish shell
echo "Installing Fish shell..."
sudo apt update -y
sudo apt install fish -y

# install nix
sh <(curl -L https://nixos.org/nix/install) --daemon

# Neovim
echo "Installing Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
# Move it to /opt/nvim/ for global usage
sudo mkdir -p /opt/nvim
sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim

# Starship prompt
echo "Installing Starship prompt..."
curl -sS https://starship.rs/install.sh | sh -s -- --yes

# Zoxide
echo "Installing Zoxide..."
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh -s 

# Docker
# Add the official Docker repo
sudo mkdir -m 0755 -p /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update

# Install Docker engine and standard plugins
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras

# Give this user privileged Docker access
sudo usermod -aG docker ${USER}

# Limit log size to avoid running out of disk
echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json

# LazyDocker
echo "Installing LazyDocker..."
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# Optional packages
echo "Installing optional packages..."
sudo apt install -y bat btop kitty jq

# Git aliases
echo "Configuring Git aliases..."
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.s status

# Fonts
echo "Installing fonts..."
mkdir -p ~/.local/share/fonts
cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono 
cp JetBrainsMono/*.ttf ~/.local/share/fonts
rm -rf JetBrainsMono.zip JetBrainsMono
fc-cache
cd -

# Symlink dotfiles
echo "Creating symlinks for dotfiles..."
stow fastfetch fish kitty nvim scripts tmux wallpapers gtk rofi dunst

# source tmux
tmux source-file ~/.tmux.conf

echo "Installation finished at $(date)"

