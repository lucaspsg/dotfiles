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
