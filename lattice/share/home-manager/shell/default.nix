{pkgs, ...}: let
  dw = pkgs.writeScriptBin "dw" ''
    ${pkgs.diceware}/bin/diceware -n 3 -d '-' --no-caps $@
  '';
  uank = pkgs.writeScriptBin "uank" ''
    ${pkgs.uni}/bin/uni search "$1"\
    | ${pkgs.yank}/bin/yank\
    | ${pkgs.gnused}/bin/sed "s/'//g"\
    | ${pkgs.wl-clipboard}/bin/wl-copy
  '';
in {
  imports = [
    ./starship.nix
    ./ssh
  ];
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
  home = {
    packages = with pkgs; [
      awscli2
      jaq
      pandoc
      mermaid-filter
      mermaid-cli
      mdbook-mermaid
      mdbook
      mdbook-pdf
      just
      moreutils
      bc
      bind # the one and only
      curl
      ddgr # duckduckgo
      deno
      diceware
      dw
      emoji-picker
      entr # file monitor
      fd
      gh
      gpg-tui
      jq
      lazydocker
      lazygit
      libsecret
      lldb
      lynx
      nixd
      nodejs
      pgcli # postgres cli
      pinentry-qt
      prettierd
      qrtool
      rbw # bitwarden cli
      ripgrep
      rsync
      rustup
      shellcheck # shell  linter
      steam-run # simulates standard linux filesystem
      svelte-check
      typescript
      uank
      uni # unicode cli tool
      unipicker # unicode cli
      unzip
      xz
    ];
    sessionPath = [
      "~/.local/bin" # why no work
    ];
  };
  programs = {
    bash = {
      enable = true;
      initExtra = ''
        set -o vi
        export PATH="$PATH:$HOME/.local/bin:$PATH:$HOME/.cargo/bin"
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
      enableBashIntegration = true;
      extraOptions = ["--group-directories-first" "--header"];
      git = true;
      icons = "auto";
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
        pinentry = pkgs.pinentry-qt;
      };
    };
    yazi = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        log = {
          enabled = true;
        };
        manager = {
          sort_by = "mtime";
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
      pinentry = {
        package = pkgs.pinentry-qt;
      };
      defaultCacheTtl = 14400; #4h in seconds
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
