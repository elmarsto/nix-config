{
  config,
  pkgs,
  lib,
  ...
}: let
  dw = pkgs.writeScriptBin "dw" ''
    ${pkgs.diceware}/bin/diceware -n 3 -d '-' --no-caps $@
  '';
in {
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
  home.packages = with pkgs; [
    bind
    curl
    ddgr
    diceware
    dw
    gpg-tui
    gdb
    libsecret
    lldb
    ncdu
    pinentry.qt
    rbw
    ripgrep
    rsync
    steam-run
    unzip
    xz
  ];
  imports = [
    ./starship.nix
    ./tmux.nix
    ./ssh
  ];
  programs = {
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
    broot.enable = true;
    eza = {
      enable = true;
      enableAliases = true;
      extraOptions = ["--group-directories-first" "--header"];
      git = true;
      icons = true;
    };
    fzf.enable = true;
    gpg = {
      enable = true;
      mutableKeys = true;
      mutableTrust = true;
      publicKeys = [
        {
          source = ./gpg-pubkeys.txt;
          trust = "full";
        }
      ];
    };
    man = {
      enable = true;
      generateCaches = true;
    };
    readline.enable = true;
    rbw = {
      enable = true;
      settings = {
        email = "liz.mars@pm.me";
        lock_timeout = 300;
        pinentry = "qt";
      };
    };
    watson.enable = true;
    yazi = {
      enable = true;
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
    gpg-agent = {
      enable = true;
      enableExtraSocket = true;
      pinentryFlavor = "qt";
    };
    gnome-keyring = {
      enable = true;
      components = ["pkcs11" "secrets"];
    };
    pueue = {
      enable = true;
      settings.daemon.default_parallel_tasks = 4;
    };
    recoll = {
      enable = true;
      settings = {
        loglevel = 5;
        nocjk = true;
        "skippedNames+" = ["node_modules" "target" "result" ".git" "*.iso"];
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
          "~/too-many-secrets"
          "~/work"
        ];
      };
    };
    syncthing.enable = true;
    udiskie = {
      enable = true;
      automount = false; # may help with garmin mess
    };
  };
}
