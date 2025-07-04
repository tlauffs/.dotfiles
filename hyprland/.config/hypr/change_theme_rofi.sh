#!/usr/bin/env bash

echo -e "rose-pine    <span foreground='#191724'>●</span> <span foreground='#e0def4'>●</span> <span foreground='#c4a7e7'>●</span> <span foreground='#f6c177'>●</span>\n\
catppuccin   <span foreground='#1e1e2e'>●</span> <span foreground='#cdd6f4'>●</span> <span foreground='#89b4fa'>●</span> <span foreground='#f38ba8'>●</span>\n\
gruvbox      <span foreground='#1d2021'>●</span> <span foreground='#fbf1c7'>●</span> <span foreground='#83a598'>●</span> <span foreground='#d79921'>●</span>\n\
kanagawa     <span foreground='#1F1F28'>●</span> <span foreground='#DCD7BA'>●</span> <span foreground='#7E9CD8'>●</span> <span foreground='#E46876'>●</span>\n\
digital-rain <span foreground='#000000'>●</span> <span foreground='#00FF00'>●</span> <span foreground='#5482AF'>●</span> <span foreground='#64C83C'>●</span>"\
| rofi -dmenu -markup-rows -p "Select Theme" \
| awk '{print $1}' \
| xargs ~/.local/bin/apply-theme

