set-option -g status-left-length 20
set-option -g status-left "[#S]$USER "
set-option -g prefix C-q
unbind-key C-b
bind-key C-q send-prefix
