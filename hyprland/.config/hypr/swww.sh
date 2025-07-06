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
  # Get the filename of the current wallpaper
  CURRENT_WALLPAPER_FILENAME=$(swww query | head -n 1 | awk -F 'image: ' '{print $2}' | xargs basename)

  # Find all wallpapers in the directory
  ALL_WALLPAPERS=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \))

  # Exclude the current wallpaper by its filename
  CANDIDATE_WALLPAPERS=$(echo "$ALL_WALLPAPERS" | grep -vF "$CURRENT_WALLPAPER_FILENAME")

  # If filtering left no wallpapers (e.g., only one wallpaper in the dir), use the full list
  if [ -z "$CANDIDATE_WALLPAPERS" ]; then
    CANDIDATE_WALLPAPERS="$ALL_WALLPAPERS"
  fi

  if [ -n "$CANDIDATE_WALLPAPERS" ]; then
    NEW_WALLPAPER=$(echo "$CANDIDATE_WALLPAPERS" | shuf -n 1)
    swww img "$NEW_WALLPAPER" --transition-type grow --transition-duration 1.2 --transition-pos 0.9,0.1 --transition-fps 60
    echo "Wallpaper set to: $NEW_WALLPAPER"
  else
    echo "No wallpapers found in '$WALLPAPER_DIR'." >&2
  fi
else
  echo "Wallpaper directory '$WALLPAPER_DIR' does not exist. Skipping wallpaper change." >&2
fi
