{ pkgs, home-manager, ... }: let
  authorizedKeyFiles = [
    ./users/id_fourcade.pub
    ./users/id_bowsprit.pub
    ./users/id_lain.pub
    ./users/id_sopwith.pub
  ];
 in {
  nix.settings.trusted-users = [ "root" "lattice" ];
  imports = [ home-manager.nixosModules ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users = {
      root = {
        home = { 
          username = "root";
          stateVersion = "23.11";
          packages = with pkgs; [
            appimage-run
            bat
            btrfs-progs
            cachix
            ccache
            cifs-utils
            conntrack-tools
            curl 
            dconf
            dconf2nix
            dig
            ethtool
            fd
            file
            git-interactive-rebase-tool
            gnupg1
            gnutar
            gsettings-desktop-schemas
            inotify-tools
            iotop
            libhugetlbfs.bin
            lrzsz
            lsof 
            lynx
            minicom
            ncdu
            netcat 
            nethogs
            nfs-utils
            nfstrace
            nix-diff 
            nix-doc
            nix-du
            nix-prefetch
            nix-prefetch-git
            nix-prefetch-github
            nix-script
            nix-template
            nix-top
            nix-tree
            nurl
            nmap
            openssl_3_1
            pciutils
            pv
            qemu-utils
            qemu_kvm
            rng-tools
            rsync
            sccache
            signify
            smbnetfs
            socat
            stow
            tcpdump
            traceroute
            unar
            unionfs-fuse
            footswitch
            unzip
            wget
            whois
            xz
            # TODO: move to yubikey.nix
            yubico-pam
            yubico-piv-tool
            yubikey-manager
            yubikey-manager-qt
            yubikey-personalization
            yubikey-personalization-gui
            yubioath-flutter
          ];
        };
        programs = {
          bash = {
            enable = true;
            shellAliases = {
              temporal-enema = "cat /dev/null > ~/.bash_history && history -c && exit";
            };
            initExtra = ''
              set -o vi
            '';
          };
          bottom.enable = true;
          eza = {
            enable = true;
            icons = true;
            git = true;
            extraOptions = [ "--group-directories-first" "--header" ]; 
            enableAliases = true;
          };
          fzf.enable = true;
          git = {
            enable = true;
            lfs.enable = true;
            delta.enable = true;
            userName = "lattice as root";
            userEmail = "lattice@localhost";
            ignores = [
              " .stignore"
              "*.secret"
              "*.stversions"
              "*.swo"
              "*.swp"
              "*~"
              ".DS_STORE/"
              ".stfolder/"
              ".stversions/"
              ".trash/"
              "/$RECYCLE.BIN"
              "/.Trashes"
              ".*trashed"
            ];
            extraConfig = {
              pull.ff = "only";
              push.autoSetupRemote = true;
              global.sequence.editor = "${pkgs.git-interactive-rebase-tool}/bin/interactive-rebase-tool";
              init.defaultBranch = "main";
            };
          };
          gpg.enable = true; # TODO: more here
          man = {
            enable = true;
            generateCaches = true;
          };
          nix-index.enable = true;
          readline.enable = true;
          ripgrep.enable = true;
          rbw = {
            enable = true;
            settings = {
              email = "lattice@saccades.ca";
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
              set -g status "on"
              set -g status-justify "left"
              set -g status-left-length "100"
              set -g status-right-length "100"
            '';
          };
          ssh = {
            enable = true;
            compression = true;
            controlMaster = "auto";
            controlPath = "/tmp/root-%r@%h:%p";
            controlPersist = "10m";
            extraConfig = ''
              Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
              KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group-exchange-sha256
              MACs hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,umac-128-etm@openssh.com
              HostKeyAlgorithms ssh-ed25519,ssh-ed25519-cert-v01@openssh.com,sk-ssh-ed25519@openssh.com,sk-ssh-ed25519-cert-v01@openssh.com,rsa-sha2-256,rsa-sha2-256-cert-v01@openssh.com,rsa-sha2-512,rsa-sha2-512-cert-v01@openssh.com
            '';
          };
          neovim = {
            enable = true;
            vimAlias = true;
            # TODO: pull this from ../home-manager/neovim/vim.nix
            extraConfig = ''
              au CursorHold,CursorHoldI * checktime
              au FocusGained,BufEnter * :checktime
              let &showbreak = '⮩'
              set smartindent
              set autoread
              set backspace=indent,eol,start
              set expandtab
              set foldlevel=3
              set foldmethod=expr
              set laststatus=0 
              set list
              set listchars=precedes:«,extends:»
              set mouse=a
              set nospell
              set nu
              set relativenumber
              set shiftwidth=2
              set signcolumn=yes
              set smarttab
              set softtabstop=2
              set tabstop=2
              set termguicolors
              set undofile
              set wrap
              syntax on
            '';
          }; 
          yazi = {
            enable = true;
            enableBashIntegration = true;
            settings.manager = {
              sort_by = "modified";
              sort_dir_first = true;
              sort_reverse = true;
            };
          };
        };
      };
    };
  };
  users.users = {
    root.openssh.authorizedKeys.keyFiles = authorizedKeyFiles;
    lattice = {
      createHome = false;
      isNormalUser = true;
      openssh.authorizedKeys.keyFiles = authorizedKeyFiles;
      # TODO: maybe DRY this out? I see these settings duplicated elsewhere (grep 'extraSettings')
      extraGroups = [
        "adbusers"
        "adm"
        "audio"
        "cdrom"
        "disk"
        "docker"
        "doas"
        "dialout"
        "flatpak"
        "input"
        "libvirtd"
        "lp"
        "podman"
        "qemu-libvirtd"
        "render"
        "scanner"
        "systemd-journal"
        "video"
        "wheel"
      ];
    };
  };
  security = {
    doas.extraRules = [
      {
        runAs = "root";
        groups = [ "wheel" ];
        noPass = false;
        keepEnv = false;
      }
    ];
    polkit.adminIdentities = [ "unix-user:lattice" ];
  };
  services = {
    locate.prunePaths = [ "/home/lattice/.mozilla" "/home/lattice/.local" "/home/lattice/.cache" "/home/lattice/.thunderbird"  ];
  };
}
