#!/bin/bash

sudo pacman -Syu --needed \
  aws-cli-v2 \
  k9s \
  fluxcd \
  kubectl \
  python-pipx

pipx install aws-sso-util
