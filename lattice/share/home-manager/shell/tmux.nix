{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.tmux = {
    enable = true;
    mouse = true;
    newSession = false;
    keyMode = "vi";
    historyLimit = 100000;
    terminal = "tmux-256color";
    extraConfig = ''
      bind-key s choose-tree -Zs
      bind r source-file ~/.config/tmux/tmux.conf
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      bind < resize-pane -L 10
      bind > resize-pane -R 10
      bind = resize-pane -D 10
      bind - resize-pane -U 10
      bind x rotate-window

      set -s copy-command 'wl-copy'
      set -g mode-style "fg=#82aaff,bg=#3b4261"

      set -g message-style "fg=#82aaff,bg=#3b4261"
      set -g message-command-style "fg=#82aaff,bg=#3b4261"

      set -g pane-border-style "fg=#3b4261"
      set -g pane-active-border-style "fg=#82aaff"

      set -g status "on"
      set -g status-justify "left"

      set -g status-style "fg=#82aaff,bg=#1e2030"

      set -g status-left-length "100"
      set -g status-right-length "100"

      set -g status-left-style NONE
      set -g status-right-style NONE

      set -g status-left "#[fg=#1b1d2b,bg=#82aaff,bold] #S #[fg=#82aaff,bg=#1e2030,nobold,nounderscore,noitalics]"
      set -g status-right "#[fg=#1e2030,bg=#1e2030,nobold,nounderscore,noitalics]#[fg=#82aaff,bg=#1e2030] #{prefix_highlight} #[fg=#3b4261,bg=#1e2030,nobold,nounderscore,noitalics]#[fg=#82aaff,bg=#3b4261] %Y-%m-%d  %I:%M %p #[fg=#82aaff,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#1b1d2b,bg=#82aaff,bold] #h "
      if-shell '[ "$(tmux show-option -gqv "clock-mode-style")" == "24" ]' {
        set -g status-right "#[fg=#1e2030,bg=#1e2030,nobold,nounderscore,noitalics]#[fg=#82aaff,bg=#1e2030] #{prefix_highlight} #[fg=#3b4261,bg=#1e2030,nobold,nounderscore,noitalics]#[fg=#82aaff,bg=#3b4261] %Y-%m-%d  %H:%M #[fg=#82aaff,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#1b1d2b,bg=#82aaff,bold] #h "
        }

        setw -g window-status-activity-style "underscore,fg=#828bb8,bg=#1e2030"
        setw -g window-status-separator ""
        setw -g window-status-style "NONE,fg=#828bb8,bg=#1e2030"
        setw -g window-status-format "#[fg=#1e2030,bg=#1e2030,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#1e2030,bg=#1e2030,nobold,nounderscore,noitalics]"
        setw -g window-status-current-format "#[fg=#1e2030,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#82aaff,bg=#3b4261,bold] #I  #W #F #[fg=#3b4261,bg=#1e2030,nobold,nounderscore,noitalics]"

        # tmux-plugins/tmux-prefix-highlight support
        set -g @prefix_highlight_output_prefix "#[fg=#ffc777]#[bg=#1e2030]#[fg=#1e2030]#[bg=#ffc777]"
        set -g @prefix_highlight_output_suffix ""
    '';
  };
}
