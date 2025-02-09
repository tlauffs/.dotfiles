#!/bin/bash

nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
nix-channel --update
nix-env -iA nixpkgs.neovim nixpkgs.fish nixpkgs.starship nixpkgs.zoxide nixpkgs.lazydocker

nix-env -iA nixpkgs.python39 nixpkgs.nodejs_23 nixpkgs.php84

# change npm prefix
mkdir -p "${HOME}/.npm/global"
npm config set prefix "${HOME}/.npm/global"

