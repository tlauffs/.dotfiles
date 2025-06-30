#!/usr/bin/env bash

# Get the current theme name from the file written by apply-theme
CURRENT_THEME_NAME=$(cat "$HOME/.config/current_theme" 2>/dev/null)

# Fallback to a default theme if the file doesn't exist or is empty
if [ -z "$CURRENT_THEME_NAME" ]; then
  CURRENT_THEME_NAME="rose-pine" # Your preferred default theme
fi

# Construct the wallpaper directory path
WALLPAPER_DIR="$HOME/wallpapers/$CURRENT_THEME_NAME/"

# Set a random wallpaper from the theme's directory
if [ -d "$WALLPAPER_DIR" ]; then
  NEW_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)

  if [ -n "$NEW_WALLPAPER" ]; then
    hyprctl hyprpaper preload "$NEW_WALLPAPER"
    hyprctl hyprpaper wallpaper ",""$NEW_WALLPAPER"
    echo "Hyprpaper: Wallpaper set to: $NEW_WALLPAPER"
  else
    echo "Hyprpaper: No wallpapers found in $WALLPAPER_DIR. Skipping wallpaper change."
  fi
else
  echo "Hyprpaper: Wallpaper directory '$WALLPAPER_DIR' does not exist. Skipping wallpaper change." >&2
fi