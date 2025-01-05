# .dotfiles

no more nix, no more home-mangaer / just gnu stow and bash

## Updating
To update the dotfiles pull this repo including its submodules:
```
git submodule update --init --recursive
git submodule update --recursive
git pull --recurse-submodules
```
## GNU Stow (Manage .dotfiles/Symlinks)
- install (apt): sudo apt install stow build-essential
- symlink all dotfiles: `stow .`
- cleanup all symlinks : `stow -D .` 

## Install
For Ubuntu there is a Install script:
```
./install.sh
```
Optionaly install nix package manager and packages:
```
sh <(curl -L https://nixos.org/nix/install) --daemon
nix-env -iA nixpkgs.just nixpkgs.yazi nixpkgs.fastfetch
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

#### Hyprland/Wayland Packages
- hyprland
- hyprpaper
- hyprlock
- tofi
- wdisplays
- wl-clipboard


