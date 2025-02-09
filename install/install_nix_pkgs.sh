#!/bin/bash

nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
nix-channel --update
nix-env -iA nixpkgs.neovim nixpkgs.fish nixpkgs.starship nixpkgs.zoxide nixpkgs.lazydocker
