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
sudo pacman -S \
        vim \
		stow \
		tmux \
        jq \
        nodejs npm \
        php composer \
        rust cargo \
        neovim \
        fish \
        starship \
        zoxide \
        bat \
        dust \
        tldr \
        btop \
        direnv \
        fastfetch \
		lazydocker \
		yazi

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

# Install workmux
printf 'Installing workmux\n'
curl -fsSL https://raw.githubusercontent.com/raine/workmux/main/scripts/install.sh | bash

# Docker for workmux sandboxing
printf 'Installing Docker\n'
sudo pacman -S docker docker-compose
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"

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

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/VictorMono.zip
unzip VictorMono.zip -d VictorMono
cp VictorMono/*.ttf ~/.local/share/fonts
rm -rf VictorMono.zip VictorMono

fc-cache -f -v
cd -

echo "Installation finished at $(date)"
