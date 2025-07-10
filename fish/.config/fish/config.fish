# Set the editor to Vim
set -gx EDITOR nvim
set -gx VISUAL nvim

# Initialize Starship prompt
starship init fish | source

# Initialize Zoxide (ensure it's installed)
zoxide init --cmd cd fish | source

# starship
starship init fish | source

# greeting
set -g fish_greeting ""

# Hook for Direnv
# direnv hook fish | source

# aliases
abbr rm "rm -i"
abbr cp "cp -i"
abbr mv "mv -i"
abbr mkdir "mkdir -p"
abbr .. 'cd ..'
abbr ... 'cd ../..'

abbr yayf 'yay -Slq | fzf --multi --preview "yay -Sii {1}" | xargs -ro yay -S'

# Add Neovim to PATH
set -Ux PATH /opt/nvim $PATH

# add to path
set -U fish_user_paths $HOME/.local/bin $fish_user_paths

# add npm path
set -gx PATH $HOME/.npm/global/bin $PATH

# Optional: for desktop detection
if test "$XDG_SESSION_TYPE" = "wayland"
    set -gx XDG_CURRENT_DESKTOP Hyprland
    set -gx XDG_SESSION_DESKTOP Hyprland
end

clear
fastfetch
