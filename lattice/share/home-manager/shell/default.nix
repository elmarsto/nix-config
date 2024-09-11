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
      ast-grep # treesitter + grep
      pkgs.bash-language-server
      bind # the one and only
      black # python formatter
      boost
      buf-language-server # protobuf LS
      ccls # C/C++ LS
      chars # unicode cli
      charm-freeze # screencaps of code
      choose # (awk alternatives) pick ranges and regexes
      cicero-tui # unicode picker
      clang-analyzer
      clang-tools
      clang-tools # clangd
      cmake-language-server
      comby # syntax-aware (AST?) search/replace CLI
      croc # send things between computers
      ctop
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
      emoji-picker
      entr # file monitor
      #eslint
      eslint_d
      fd
      fennel # scheme that compiles to lua
      fennel-ls
      fx # terminal json viewer
      gdb
      gh
      gimoji # gitmoji-cli but in rust
      gist
      gitmoji-cli
      gpg-tui
      graphql-language-service-cli
      helm-ls
      htmx-lsp
      hyperfine
      jaq # fast jq
      jc # serialize common unix outputs to json
      jless # json pager
      jo # json object thingy
      jq
      jq-lsp
      kompose # docker-compose for k8s
      kubectl
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
      marksman # langserver for .md
      miller # csv cli tool
      minikube
      nixd
      nodejs
      nsh # small posix shell in rust
      nushell # shell alternative
      ocamlPackages.magic-trace
      pandoc
      pgcli # postgres cli
      pinentry.qt
      plocate # faster `locate`
      postgres-lsp
      pprof # visualize profiling data
      prettierd
      pv # pipeline monitor/progress baer
      pyright # python linter
      python312
      python312Packages.ipython
      qrtool
      rbw # bitwarden cli
      ripgrep
      ripgrep-all
      rsync
      rustup
      shellcheck # shell  linter
      shfmt # shell `prettier`
      #sqlfluff # sql linter/formatter
      sqls # sql langserver
      statix # nix linter
      steam-run # simulates standard linux filesystem
      stylelint # css linter
      taplo
      typescript
      typescript-language-server
      uank
      uni # unicode cli tool
      unipicker # unicode cli
      unzip
      #uwc # unicode wordcount
      vale
      vim-language-server
      #visidata # vim but for csv
        #vscode-langservers-extracted # html, json, css langservers
      wring # CSS selectors / xpath html extraction tool ('jq for html')
      xh # HTTP REST tool
      xsv # csv cli tool
      xz
      yaml-language-server
      yank # pipe to clipboard with picker
      zk # zettelkasten cli
      zls # zig lsp
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
