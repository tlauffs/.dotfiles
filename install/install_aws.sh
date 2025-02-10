#!/bin/bash

nix-env -iA nixpkgs.awscli2 nixpkgs.aws-sso-cli nixpkgs.k9s nixpkgs.fluxcd nixpkgs.kubectl nixpkgs.pipx 
pipx install aws-sso-util

