# .dotfiles

no more nix, no more home-mangaer / just gnu stow and bash

## Updating
To update the dotfiles pull this repo including its submodules:
```
git pull --recurse-submodules
```
## GNU Stow (Manage .dotfiles/Symlinks)
- install (Deb): sudo apt install stow build-essential
- symlink all dotfiles: `stow .`
- cleanup all symlinks : `stow -D .` 

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
- dust
- tldr
- bat
- btop
- yazi
- direnv
- devbox
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


