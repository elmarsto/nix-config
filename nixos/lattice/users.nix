{ pkgs, ... }: let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  authorizedKeyFiles = [
    ./ssh/id_fourcade.pub
    ./ssh/id_bowsprit.pub
    ./ssh/id_lain.pub
    ./ssh/id_sopwith.pub
  ];
 in {
  nix.settings.trusted-users = [ "root" "lattice" ];
  imports = [ <home-manager/nixos> ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users = {
      root = {
        home = { 
          username = "root";
          stateVersion = "23.11";
          packages = with pkgs; [
            #age # modern encryption tool
            #agedu # track down wasted disk space
            #angle-grinder # log tool
            appimage-run
            bat # colorized cat/less
            btrfs-progs
            cachix
            ccache
            cifs-utils
            conntrack-tools
            #ctop # container top, e.g. for docker/podman
            curl 
            dconf
            dconf2nix
            dig
            #dogdns # advanced dig
            #du-dust #advanced du
            #duf # advaced du
            #dufs # webdav on the spot
            #entr # run commands when files change
            ethtool
            fd
            file
            git-interactive-rebase-tool
            glances # monitoring tool (TUI)
            gnupg1
            gnutar
            gsettings-desktop-schemas
            inotify-tools
            iotop
            #just # command runner 
            #lazydocker # TUI for docker/podman
            libhugetlbfs.bin
            #lnav # logfile navigator
            lorri # nixos build tool
            lrzsz # zmodem etc
            lsof 
            lynx
            minicom
            ncdu # TUI for du
            netcat 
            nethogs # top for net connections
            nfs-utils
            nfstrace
            niv # nix dep manager
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
            #spice
            stow
            tcpdump
            #tcpreplay
            #tcptrack
            traceroute
            #tshark
            unar
            unionfs-fuse
            unstable.footswitch
            unzip
            #virt-manager
            #virt-viewer
            wget
            whois
            #wineWowPackages.stable
            xz
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
# what does this even do?
#        setEnv  = [
#          "HOME=/root"
#          "USER=root"
#          "NIX_PROFILES=/run/current-system/sw /nix/var/nix/profiles/default /etc/profiles/per-user/root /root/.nix-profile /var/lib/flatpak/exports /root/.local/share/flatpak/exports"
#          "NIX_PATH=/root/.nix-defexpr/channels:nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels"
#          "NIXPKGS_CONFIG=/etc/nix/nixpkgs-config.nix"
#          "NIX_USER_PROFILE_DIR=/nix/var/nix/profiles/per-user/root"
#          "__NIXOS_SET_ENVIRONMENT_DONE=1"
#        ];
      }
    ];
    polkit.adminIdentities = [ "unix-user:lattice" ];
  };
  services = {
    locate.prunePaths = [ "/home/lattice/.mozilla" "/home/lattice/.local" "/home/lattice/.cache" "/home/lattice/.thunderbird"  ];
#    postgresql = {
#     ensureDatabases = [ "lattice" "root" ];
#     ensureUsers = [
#       {
#         name = "lattice";
#         ensureClauses = {
#           login = true;
#           superuser = true;
#           createrole = true;
#           createdb = true;
#         };
#         ensureDBOwnership = true;
#       }
#       {
#         name = "root";
#         ensureClauses = {
#           login = true;
#           superuser = true;
#           createrole = true;
#           createdb = true;
#         };
#         ensureDBOwnership = true;
#       }
#     ];
#    };
  };
}
