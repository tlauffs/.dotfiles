
# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, exit.
case $- in
    *i*) ;;
      *) return;;
esac

# History settings
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Update window size
shopt -s checkwinsize

# Enable color support for ls and add aliases
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b ~/.dircolors)"
    alias ls='ls --color=auto'
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
fi

# Enable bash completion
if ! shopt -oq posix; then
  [ -f /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
fi

case $- in
    *i*) 
        # Start Fish shell for interactive sessions
        exec fish
        ;;
    *) 
        return
        ;;
esac

if [ -n "$PS1" ]; then
    exec fish
fi

