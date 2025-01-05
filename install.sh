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

# Update and install dependencies
echo "Updating apt repositories and installing dependencies..."
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y curl git unzip gpg wget make gcc ripgrep fzf
# Install additional packages
echo "Installing packages..."
sudo apt install -y vim stow tmux xclip

# Fish shell
echo "Installing Fish shell..."
sudo apt-add-repository ppa:fish-shell/release-3 -y
sudo apt update -y
sudo apt install fish -y

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
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh -s 

# Docker
# Add the official Docker repo
sudo install -m 0755 -d /etc/apt/keyrings
sudo wget -qO /etc/apt/keyrings/docker.asc https://download.docker.com/linux/ubuntu/gpg
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
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
sudo apt install -y  bat btop kitty jq

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
unzip JetBrainsMono-1.0.0.zip -d JetBrainsMono
cp JetBrainsMono/*.ttf ~/.local/share/fonts
rm -rf JetBrainsMono.zip JetBrainsMono 

# Mise: Install mise for managing multiple versions of languages. See https://mise.jdx.dev/
sudo install -dm 755 /etc/apt/keyrings
wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1>/dev/null
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=$(dpkg --print-architecture)] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
sudo apt update
sudo apt install -y mise

# Node
mise use --global node@lts

# Python
mise use --global python@latest

# Php
sudo add-apt-repository -y ppa:ondrej/php
sudo apt -y install php8.3 php8.3-{curl,apcu,intl,mbstring,opcache,pgsql,mysql,sqlite3,redis,xml,zip}
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --quiet && sudo mv composer.phar /usr/local/bin/composer
rm composer-setup.php

# Symlink dotfiles
echo "Creating symlinks for dotfiles..."
stow fastfetch fish kitty nvim scripts tmux wallpapers 

# source tmux
tmux source-file ~/.tmux.conf

echo "Installation finished at $(date)"

