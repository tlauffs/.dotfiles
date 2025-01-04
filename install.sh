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
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# nix
echo "Installing Nix..."
sh <(curl -L https://nixos.org/nix/install) --daemon --no-prompt

# Update and install dependencies
echo "Updating apt repositories and installing dependencies..."
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y curl git unzip gpg wget make gcc ripgrep fzf python3 python3-venv python3-pip python3-launchpadlib

# Install additional packages
echo "Installing packages..."
sudo apt install -y vim stow tmux xclip

# Kitty terminal
echo "Installing Kitty terminal..."
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Fish shell
echo "Installing Fish shell..."
echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_12/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null
sudo apt update -y
sudo apt install -y fish 

# Neovim
echo "Installing Neovim..."
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update -y
sudo apt install -y neovim

# Starship prompt
echo "Installing Starship prompt..."
curl -sS https://starship.rs/install.sh | sh -s -- --yes

# Zoxide
echo "Installing Zoxide..."
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh -s -- --yes

# Docker
echo "Installing Docker..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo wget -qO /etc/apt/keyrings/docker.asc https://download.docker.com/linux/debian/gpg
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras

# Add user to Docker group
sudo usermod -aG docker "${USER}"

# LazyDocker
echo "Installing LazyDocker..."
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# Optional packages
echo "Installing optional packages..."
sudo apt install -y du-dust tldr bat btop

# Just and Yazi via Nix
echo "Installing Just, Yazi and fastfetch via Nix..."
nix-env -iA nixpkgs.just nixpkgs.yazi nixpkgs.fastfetch

# Git aliases
echo "Configuring Git aliases..."
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.s status

# Fonts
echo "Installing fonts..."
mkdir -p ~/.local/share/fonts
wget https://download.jetbrains.com/fonts/JetBrainsMono-1.0.0.zip
unzip JetBrainsMono-1.0.0.zip -d ~/.local/share/fonts
fc-cache -f -v

# Symlink dotfiles
echo "Creating symlinks for dotfiles..."
stow fastfetch fish kitty nvim scripts tmux wallpapers xprofile

echo "Installation finished at $(date)"

