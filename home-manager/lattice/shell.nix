{ config, pkgs, lib, ... }:
let
  # FIXME: figure out what is pulling in openssl and either remove or fix the package. INSECURE is, well, insecure.
  hms = pkgs.writeScriptBin "hms" ''
    #export NIXPKGS_ALLOW_INSECURE=1;
    rm -f ~/.config/mimeapps.list;
    home-manager switch
  '';
  dw = pkgs.writeScriptBin "dw" ''
    ${pkgs.diceware}/bin/diceware -d ' ' --no-caps $@
  '';
  unstable = config.lattice.unstable;
  termPkgs = with pkgs; [
    #age
    #angle-grinder
    #bc
    bind
    #btop
    curl
    ddgr
    diceware
    dw
    #dogdns
    #du-dust
    #duf
    #entr
    fd
    #ffmpegthumbnailer
    file
    #glances
    glow
    hms
    #hyperfine
    inotify-tools
    #libossp_uuid
    #lnav
    #lrzsz
    #magic-wormhole
    #minicom
    #mosh
    ncdu
    #netcat
    #nfs-ganesha
    pinentry.gnome3
    #pv
    ripgrep
    #ripgrep-all
    rsync
    #sd
    #signify
    #smbnetfs
    #socat
    #sshfs
    steam-run
    #traceroute
    #unar
    #unionfs-fuse
    unstable.footswitch
    unzip
    #websocat
    #whois
    #xh
    xz
  ];
  guiPkgs = with pkgs; [
    #gsmartcontrol
    unstable.bitwarden
  ];
in
{
  imports = [
    ./starship.nix
  ];
  config = {
    editorconfig = {
      enable = true;
      settings = {
        "*" = {
          indent_style = "space";
          indent_size = 2;
          charset = "utf-8";
          end_of_line = "lf";
          trim_trailing_whitespace = true;
          insert_final_newline = true;
          max_line_length = 80;
        };
      };
    };
    home.packages = if config.lattice.gui.enable then termPkgs ++ guiPkgs else termPkgs;
    xdg = {
      mimeApps = {
        enable = true;
        defaultApplications = {
          "default-web-browser" = [ "firefox.desktop" ];
        };
      };
    };
    programs = {
      #aria2.enable = true;
      bash = {
        enable = true;
        initExtra = ''
          set -o vi
        '';
      };
      bat = {
        enable = true;
        config = {
          theme = "TwoDark";
        };
      };
      bottom.enable = true;
      # direnv is in nix.nix
      eza = {
        enable = true;
        icons = true;
        git = true;
        extraOptions = [ "--group-directories-first" "--header" ];
        enableAliases = true;
      };
      fzf.enable = true;
      gpg.enable = true;
      man = {
        enable = true;
        generateCaches = true;
      };
      #pistol = {
      #  associations = [ ];
      #  enable = true;
      #};
      readline.enable = true;
      rbw = {
        enable = true;
        settings = {
          email = "liz.mars@pm.me";
          lock_timeout = 300;
          pinentry = "gnome3";
        };
      };
      tmux = {
        enable = true;
        mouse = true;
        newSession = true;
        keyMode = "vi";
        historyLimit = 10000;
        terminal = "tmux-256color";
        plugins = with pkgs.tmuxPlugins; [
          resurrect
          {
            plugin = continuum;
            extraConfig = ''
              set -g @continuum-restore 'on'
              set -g @continuum-save-interval '60'
            '';
          }
        ];
        extraConfig = ''
          bind r source-file ~/.config/tmux/tmux.conf
          bind h select-pane -L
          bind j select-pane -D
          bind k select-pane -U
          bind l select-pane -R
          bind [ swap-pane -D
          bind ] swap-pane -U
          bind < resize-pane -L 10
          bind > resize-pane -R 10
          bind = resize-pane -D 10
          bind - resize-pane -U 10
          bind x rotate-window

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
      watson.enable = true;
      yazi = {
        enable = true;
        package = unstable.yazi;
        enableBashIntegration = true;
        settings = {
          log = {
            enabled = true;
          };
          manager = {
            sort_by = "modified";
            sort_dir_first = true;
            sort_reverse = true;
          };
        };
      };
      zoxide.enable = true;
    };
    services = {
      recoll = {
        enable = true;
        settings = {
          nocjk = true;
          loglevel = 5;
          topdirs = [
            "~/Audio"
            "~/Calibre Library"
            "~/DCIM"
            "~/Documents"
            "~/Downloads"
            "~/Music"
            "~/Pictures"
            "~/Videos"
            "~/code"
            "~/gosplan"
            "~/too-many-secrets"
            "~/work"
          ];
          # "~/Downloads" = {
          #   "skippedNames+" = [ "*.iso" ];
          # };
          "skippedNames+" = [ "node_modules" "target" "result" ".git" "*.iso" ];
        };
      };
      syncthing.enable = true;
    };
  };
}

