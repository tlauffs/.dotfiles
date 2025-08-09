# Set the editor to Vim
set -gx EDITOR nvim
set -gx VISUAL nvim


bind \cr fzf_history_opts
bind \cg fzf_git_log_opts


abbr yayf 'yay -Slq | fzf --multi --preview "yay -Sii {1}" | xargs -ro yay -S'

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


function fzf_history_opts --description "Simple fuzzy history search with clean output"
    # Make sure history from other fish sessions is merged (optional)
    if test -z "$fish_private_mode"
        builtin history merge
    end

    # Get all history lines with null separator (handles multi-line commands safely)
    set -l selected_commands (
        builtin history --null |
        fzf --read0 --print0 --height=70% --layout=reverse --preview='echo {}' --preview-window=down:3:wrap
    )

    if test $status -eq 0 -a -n "$selected_commands"
        # Replace commandline with selected command(s)
        # Use string split0 to handle null-separated multi-selection safely
        for cmd in (string split0 $selected_commands)
            commandline --replace -- $cmd
        end
    end

    commandline --function repaint
end

# fzf_git_log_opts: fuzzy search through git log
function fzf_git_log_opts
    if not git rev-parse --git-dir > /dev/null 2>&1
        echo "Not a git repo" >&2
        return 1
    end

    set log (git log --oneline --color=always | fzf --ansi --reverse --height=60% \
        --preview 'git show --color=always --stat --patch {1}' \
        --preview-window=right:60%:wrap)

    if test -n "$log"
        set commit_hash (string split ' ' -- $log)[1]
        commandline --insert $commit_hash
    end
end

