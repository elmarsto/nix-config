{
  config,
  pkgs,
  lib,
  ...
}: let
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
    ./tmux.nix
    ./ssh
    ./L.nix
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
    packages = with pkgs;
    with nodePackages; [
      alejandra # nix formatter
      angle-grinder # logfile navigator
      bash-language-server
      bind # the one and only
      comby # syntax-aware (AST?) search/replace CLI
      emoji-picker
      gimoji # gitmoji-cli but in rust
      uwc # unicode wordcount
      cicero-tui # unicode picker
      gitmoji-cli
      uni # unicode picker
      uank
      gist
      gh
      black # python formatter
      uwc # unicode wordcount
      chars # unicode cli
      yank # pipe to clipboard with picker
      unipicker # unicode cli
      boost
      sqlfluff # sql linter/formatter
      frogmouth # markdown browser for terminal
      buf-language-server # protobuf LS
      ccls # C/C++ LS
      choose # (awk alternatives) pick ranges and regexes
      clang-analyzer
      clang-tools
      clang-tools # clangd
      cmake-language-server
      croc # send things between computers
      ctop
      eslint
      curl
      dasel # csv/json/yaml tool like jq but universal
      ddgr # duckduckgo
      deno
      diceware
      docker-compose-language-service
      duf # disk usage/free utility
      dw
      efm-langserver
      emmet-language-server
      entr # file monitor
      eslint_d
      fd
      fennel # scheme that compiles to lua
      fennel-ls
      fx # terminal json viewer
      gdb
      gpg-tui
      graphql-language-service-cli
      helm-ls
      htmx-lsp
      hyperfine
      ast-grep # treesitter + grep
      jaq # fast jq
      jc # serialize common unix outputs to json
      jless # json pager
      jo # json object thingy
      jq
      jq-lsp
      lazydocker
      lazygit
      libsecret
      lldb
      llvm
      lnav # logfile navigator
      lua
      lua-fmt
      lua-language-server
      lynx
      magic-wormhole
      marksman
      miller # csv cli tool
      minikube
      nixd
      kompose
      kubectl
      ocamlPackages.magic-trace
      moreutils
      ncdu
      nodejs
      nsh
      nushell
      pandoc
      pgcli # postgres cli
      pinentry.qt
      plocate # faster `locate`
      pprof # visualize profiling data
      pomodoro
      postgres-lsp
      prettierd
      pv # pipeline monitor/progress baer
      pyright # python linter
      python312Packages.ipython
      python312
      rbw # bitwarden cli
      ripgrep
      ripgrep-all
      rsync
      rustup
      shellcheck # shell  linter
      shfmt # shell `prettier`
      sqls
      statix
      steam-run
      stylelint
      taplo
      tree-sitter
      typescript
      typescript-language-server
      uni # unicode cli tool
      unzip
      vale
      vim-language-server
      visidata # vim but for csv
      vscode-langservers-extracted # html, json, css langservers
      wring
      xh
      xsv # csv cli tool
      xz
      yaml-language-server
      zk # zettelkasten cli
      zls
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
        export PATH="$PATH:$HOME/.local/bin"
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
        pinentry = pkgs.pinentry-qt;
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
      pinentryPackage = pkgs.pinentry-qt;
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
  xdg = {
    configFile = {
      "vale/vale.ini".text = ''
        StylesPath = styles
        MinAlertLevel = suggestion
        Packages = proselint
        [*]
        BasedOnStyles = Vale, proselint
      '';
      "vale/styles/.ignore".text = "";
    };
    dataFile."../bin/vale-ls".source = ./vale-ls;
  };
}
