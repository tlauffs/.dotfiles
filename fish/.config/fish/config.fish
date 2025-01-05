# Set the editor to Vim
set -gx EDITOR nvim

# Initialize Starship prompt
starship init fish | source

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
