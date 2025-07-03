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
  # Get the current wallpaper for the first monitor
  CURRENT_WALLPAPER=$(swww query | head -n 1 | awk -F 'image: ' '{print $2}')

  # Find all wallpapers and select one that is not the current one
  CANDIDATE_WALLPAPERS=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) -not -path "$CURRENT_WALLPAPER")

  if [ -n "$CANDIDATE_WALLPAPERS" ]; then
    NEW_WALLPAPER=$(echo "$CANDIDATE_WALLPAPERS" | shuf -n 1)
    swww img "$NEW_WALLPAPER" --transition-type grow --transition-duration 1.2 --transition-pos 0.9,0.1
    echo "Wallpaper set to: $NEW_WALLPAPER"
  else
    echo "No other wallpapers found to switch to."
  fi
else
  echo "Wallpaper directory '$WALLPAPER_DIR' does not exist. Skipping wallpaper change." >&2
fi