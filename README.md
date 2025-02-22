# .dotfiles

## Updating
To update the dotfiles pull this repo including its submodules:
```
git submodule update --init --recursive
git submodule update --recursive
git pull --recurse-submodules
```
## GNU Stow (Manage .dotfiles/Symlinks)
- install (apt): sudo apt install stow build-essential
- symlink all dotfiles: `stow fastfetch fish kitty nvim scripts tmux wallpapers gtk`
- cleanup all symlinks : `stow -D .` 

## Install
Debian based setup
- Run setup script
```
sudo ./install/setup_deb.sh
```
- restart terminal (to start nix) then run
```
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
nix-channel --update
chmod +x ./install/install_nix_pkgs.sh
./install/install_nix_pkgs.sh
```
- symlink dotfiles
```
stow fastfetch fish kitty nvim scripts tmux wallpapers gtk
```
- optinally replace bashrc with ./bash/.bashrc or
```
rm ~/.bashrc
stow bash
```

otherwise list of  packages:

## Packages 
### Required Packages
- stow
- git
- gnumake
- nvim
- fish
- tmux
- starship
- fastfetch
- zoxide
- ripgrep
- fzf
- unzip
- gcc

### Other Packages
- just
- nodejs
- bat
- btop
- yazi
- docker
- docker-compose
- lazydocker

### Desktop Packages
- kitty
- pavucontorl
- nmapplet
- xclip
