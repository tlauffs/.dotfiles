#!/bin/bash

nix-env -iA nixpkgs.neovim nixpkgs.fish nixpkgs.starship nixpkgs.zoxide nixpkgs.lazydocker nixpkgs.fastfetch nixpkgs.bat nixpkgs.dust nixpkgs.tldr nixpkgs.btop nixpkgs.yazi nixpkgs.direnv 
nix-env -iA nixpkgs.python314 nixpkgs.nodejs_23 nixpkgs.php84 nixpkgs.php84Packages.composer nixpkgs.cargo 

# change npm prefix
mkdir -p "${HOME}/.npm/global"
npm config set prefix "${HOME}/.npm/global"

