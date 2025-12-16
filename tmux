# Options to make tmux more pleasant
set -g mouse on
set -g default-terminal "xterm-256color"

# Enable clipboard
set -g set-clipboard on

# Enable gapeless window
set -g renumber-windows on

# Make index start from 1
set -g base-index 1
setw -g pane-base-index 1

# Set scrollback size
set -g history-limit 10000

# Set focus events on for nvim
set -g focus-events on

# Set vi mode globally
setw -g mode-keys vi

# Reload config file
bind r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"

# Vim-style pane navigation (C-b h/j/k/l)
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Vim-style pane resizing (C-b H/J/K/L)
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

# Alternative: Use Ctrl-h/j/k/l for resizing
bind -r C-h resize-pane -L 5
bind -r C-j resize-pane -D 5
bind -r C-k resize-pane -U 5
bind -r C-l resize-pane -R 5

# Vim-style copy mode bindings
bind -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -in -selection clipboard"
bind -T copy-mode-vi C-v send-keys -X rectangle-toggle

# Paste from clipboard
bind p run "tmux set-buffer \"$(xclip -o -selection clipboard)\"; tmux paste-buffer"

# Alternative clipboard commands for macOS (uncomment if on macOS)
# bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
# bind p run "pbpaste | tmux load-buffer - ; tmux paste-buffer"

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'christoomey/vim-tmux-navigator'
set -g @plugin 'catppuccin/tmux'

# Configure the catppuccin plugin
set -g @catppuccin_flavor "mocha"
set -g @catppuccin_window_status_style "rounded"

# Make the status line pretty and add some modules
set -g status-right-length 100
set -g status-left-length 100
set -g status-left ""
set -g status-right "#{E:@catppuccin_status_application}"
set -ag status-right "#{E:@catppuccin_status_session}"
set -ag status-right "#{E:@catppuccin_status_uptime}"

# Bootstrap TPM
if "test ! -d ~/.tmux/plugins/tpm" \
   "run 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/tpm && ~/.tmux/plugins/tpm/bin/install_plugins'"

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
