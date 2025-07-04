#!/bin/bash

sudo pacman -Syu 
sudo pacman -S hyprland kitty thunar rofi-wayland waybar swww hyprlock gnome-keyring libsecret gnome-themes-extra papirus-icon-theme
# must have utils
sudo pacman -S dunst pipewire xdg-desktop-portal-hyprland hyprpolkitagent qt5-wayland qt6-wayland cliphist network-manager-applet brightnessctl

gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'


