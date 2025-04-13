#!/bin/bash
# enable multilib see: https://wiki.archlinux.org/title/Steam
sudo pacman -Syu mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver libva-utils
sudo pacman -Syu steam
