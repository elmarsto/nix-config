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
  home.packages = with pkgs;
  with nodePackages; [
    alejandra
    angle-grinder
    bash-language-server
    bind
    black
    boost
    sqlfluff
    buf-language-server
    ccls
    choose
    clang-analyzer
    clang-tools
    clang-tools # clangd
    cmake-language-server
    croc
    ctop
    eslint
    curl
    dasel # csv/json/yaml tool like jq but universal
    ddgr # duckduckgo
    deno
    diceware
    docker-compose-language-service
    dog
    drill
    duf
    dw
    efm-langserver
    emmet-language-server
    entr
    eslint_d
    fd
    fennel
    fennel-ls
    fx
    gdb
    gpg-tui
    graphql-language-service-cli
    helm-ls
    htmx-lsp
    hyperfine
    jaq # fast jq
    jc
    jless
    jo
    jq
    jq-lsp
    lazydocker
    lazygit
    libsecret
    lldb
    llvm
    lnav
    lua
    lua-fmt
    lua-language-server
    magic-wormhole
    marksman
    miller
    mtr
    ncdu
    nixd
    nodejs
    nsh
    nushell
    parallel
    pgcli
    pinentry.qt
    plocate
    postgres-lsp
    prettierd
    pv
    pyright
    python312Packages.ipython
    python312
    rbw
    ripgrep
    ripgrep-all
    rsync
    rustup
    shellcheck
    shfmt
    sqls
    statix
    steam-run
    stylelint
    taplo
    tree-sitter
    ts
    typescript
    typescript-language-server
    unzip
    vale
    vim-language-server
    visidata
    vscode-langservers-extracted
    wring
    xh
    xsv
    xz
    yaml-language-server
    zk
    zls
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
