#!/usr/bin/env bash

themes_dir="$HOME/.dotfiles/themes"
themes=()
max_len=0

# Find the maximum length of the theme names
for theme_file in "$themes_dir"/*.sh; do
    theme_name=$(basename "$theme_file" .sh)
    if ((${#theme_name} > max_len)); then
        max_len=${#theme_name}
    fi
done

while IFS= read -r theme_file; do
    theme_name=$(basename "$theme_file" .sh)
    source "$theme_file"
    
    colors="<span foreground='$THEME_BASE08'>●</span> <span foreground='$THEME_BASE09'>●</span> <span foreground='$THEME_BASE0A'>●</span> <span foreground='$THEME_BASE0B'>●</span> <span foreground='$THEME_BASE0C'>●</span> <span foreground='$THEME_BASE0D'>●</span> <span foreground='$THEME_BASE0E'>●</span>"
    
    # Pad the theme name with spaces for alignment
    padded_name=$(printf "%-${max_len}s" "$theme_name")

    themes+=("$padded_name  $colors")
done < <(find "$themes_dir" -maxdepth 1 -type f -name "*.sh")

theme_choice=$(for theme in "${themes[@]}"; do
    echo -e "$theme"
done | rofi -dmenu -markup-rows -p "Select Theme")

if [ -n "$theme_choice" ]; then
    selected_theme_name=$(echo "$theme_choice" | awk '{print $1}')
    ~/.local/bin/apply-theme "$selected_theme_name"
fi
