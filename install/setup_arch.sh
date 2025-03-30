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

sudo pacman -Syu 

# flathub
echo "Installing flatpak and adding flathub remote..."
sudo pacman -S flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Update and install dependencies
echo "Updating repositories and installing dependencies..."
sudo pacman -S curl git unzip wget make gcc ripgrep fzf fd sudo ca-certificates 
# Install additional packages
echo "Installing packages..."
sudo pacman -S vim stow tmux

# install nix
if [ -d "/nix" ]; then
  echo "Nix is already installed."
else
  echo "Nix is not installed. Installing..."
  sh <(curl -L https://nixos.org/nix/install) --daemon
fi

# Fish shell
echo "Installing Fish shell..."
sudo pacman -S fish

# Docker
# Add the official Docker repo
# TODO

# Install Docker engine and standard plugins
# sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras

# Give this user privileged Docker access
# sudo usermod -aG docker ${USER}

# Limit log size to avoid running out of disk
# echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json

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

echo "Installation finished at $(date)"

