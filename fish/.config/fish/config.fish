# Set the editor to Vim
set -gx EDITOR nvim

# Initialize Starship prompt
source ($HOME/.nix-profile/bin/starship init fish --print-full-init | psub)

# Initialize Zoxide (ensure it's installed)
zoxide init --cmd cd fish | source

# starship
starship init fish | source

# Hook for Direnv
# direnv hook fish | source

# aliases
abbr rm "rm -i"
abbr cp "cp -i"
abbr mv "mv -i"
abbr mkdir "mkdir -p"
abbr .. 'cd ..'
abbr ... 'cd ../..'
