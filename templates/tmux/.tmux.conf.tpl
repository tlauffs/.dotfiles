# chagne leader key to ctrl space
unbind C-b
set -g prefix C-Space
bind C-Space send-prefix

# Smart pane switching with awareness of Vim splits.
# See: https://github.com/christoomey/vim-tmux-navigator
is_vim="ps -o state= -o comm= -t '#{pane_tty}'     | grep -iqE '^[^TXZ ]+ +(\S+\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]'     "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]'     "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

bind-key -T copy-mode-vi 'C-h' select-pane -L
bind-key -T copy-mode-vi 'C-j' select-pane -D
bind-key -T copy-mode-vi 'C-k' select-pane -U
bind-key -T copy-mode-vi 'C-l' select-pane -R
bind-key -T copy-mode-vi 'C-\' select-pane -l

# use mouse
set -g mouse off

set -g base-index 1
set -g pane-base-index 1
set-window-option -g pane-base-index 1
set -sg escape-time 50
set -g detach-on-destroy off
set -g renumber-windows on

# Set true colors
set-option -sa terminal-overrides ",xterm*:Tc"
set-option -g focus-events on

# refresh
bind r source ~/.config/tmux/tmux.conf

#sessions
bind-key h choose-session

# pane splitting
bind o split-window -h
bind p split-window -v

bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

# close pane
bind q kill-pane

# Status Bar Position and Update Interval
set -g status-position bottom            
set -g status-interval 2

# Window Status Format (Normal and Current)
set -g window-status-format '#[bg=${THEME_BASE00},fg=${THEME_BASE0D}]#[bg=${THEME_BASE0D},fg=${THEME_BASE00}]#I #[bg=${THEME_BASE00},fg=${THEME_BASE05}] #{pane_current_command}#[bg=${THEME_BASE00},fg=${THEME_BASE00}]'
set -g window-status-current-format '#[bg=${THEME_BASE00},fg=${THEME_BASE08}]#[bg=${THEME_BASE08},fg=${THEME_BASE00}]#I #[bg=${THEME_BASE00},fg=${THEME_BASE05}] #{pane_current_command}#[bg=${THEME_BASE00},fg=${THEME_BASE00}]'

# Status Bar Styling (Transparent Background)
set -g status-style bg=${THEME_BASE00},fg=${THEME_BASE05}  
set -g window-status-style bg=${THEME_BASE00},fg=${THEME_BASE05}  
set -g window-status-current-style bg=${THEME_BASE00},fg=${THEME_BASE0B}  

# Status Right - Time, User, Hostname with Icons
set -g status-right-length 120
set -g status-right '#[bg=${THEME_BASE00},fg=${THEME_BASE0C}]#[bg=${THEME_BASE0C},fg=${THEME_BASE00}] #[bg=${THEME_BASE00},fg=${THEME_BASE05}] #(whoami)#[bg=${THEME_BASE00},fg=${THEME_BASE00}] #[bg=${THEME_BASE00},fg=${THEME_BASE0C}]#[bg=${THEME_BASE0C},fg=${THEME_BASE00}] #[bg=${THEME_BASE00},fg=${THEME_BASE05}] #(date +"%b %_d %H:%M") '

#kStatus Left - Tmux Icon
set -g status-left ''

# Pane Border Styling
set -g pane-border-style fg=${THEME_BASE03}
set -g pane-active-border-style fg=${THEME_BASE0B}

# Message Command Style (When You Run Commands in Tmux)
set -g message-style bg=${THEME_BASE00},fg=${THEME_BASE0B}

# Clock Mode Styling (When Showing the Clock in a Pane)
set -g clock-mode-style 24
