# TODO: refactor. this file is a mess.
# Also, consolidate stuff from system/*/network.nix and networking stuff in this file at ./network.nix
{ config, pkgs, ... }: let
  lnn = "/root/lattice-nix/nixos";
  sBin = "/run/current-system/sw/bin";
  # TODO: test
  lnu = pkgs.writeShellScriptBin "lattice-nixos-update" ''
    BIN=${sBin}
    DOAS=/run/wrappers/bin/doas
    $DOAS $BIN/nix-channel update 
    $DOAS $BIN/git -C ${lnn} pull
    $DOAS $BIN/nixos-rebuild switch
  '';
  doasWheel = {
    groups = [ "doas" ];
    noPass = true;
  };
in {
  imports = [
    ./audio.nix
    ./backup.nix
    ./cachix.nix
    ./console.nix
    ./epson.nix
    ./gui.nix
    ./razer.nix
    ./rng.nix
    ./users.nix
    ./virt.nix
    ./wacom.nix
    ./xbox.nix
    ./yubikey.nix
  ];
  nixpkgs.config.allowUnfree = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = {
   "fs.inotify.max_user_watches" = "1048576";
  };
  environment = {
    etc."dict.conf".text = "server dict.org";
    wordlist.enable = true; # needs pkgs.scowl, below
    systemPackages = with pkgs; [
      coreutils
      exfat
      findutils
      lnu
      nvd
      scowl
    ]; 
  };
  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_US.UTF-8";
  system = {
    autoUpgrade = {
      enable = false;
      allowReboot = false;
    };
    activationScripts.diff = {
      supportsDryActivation = true;
      text = ''
        ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
      '';
    };
  };
  security = {
    doas = {
      enable = true;
      extraRules = [
        ({
          cmd = "${sBin}/nixos-rebuild"; 
          args = [ "switch" ];
        } // doasWheel)
        ({
          cmd = "${sBin}/nix-channel"; 
          args = [ "--update" ];
        } // doasWheel)
        ({
          cmd = "${sBin}/git"; 
          args = [ "-C" lnn "pull" ];
        } // doasWheel)
      ];
    };
    sudo.enable = false;
    protectKernelImage = true;
    rtkit.enable = true;
    tpm2.enable = true;
    tpm2.abrmd.enable = true;
    pam = {
      enableSSHAgentAuth = true;
      loginLimits = [
        {
          domain = "*";
          type = "soft";
          item = "nofile";
          value = "8388608";
        }
        {
          domain = "*";
          type = "soft";
          item = "memlock";
          value = "8388608";
        }
        {
          domain = "*";
          type = "hard";
          item = "memlock";
          value = "8388608";
        }
      ];
    };
    polkit.adminIdentities = [ "unix-group:wheel" ];
  };
  nix = {
    package = pkgs.nixFlakes;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 21d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
  };
  services =  {
    acpid.enable = true;
    fcron = {
      enable = true;
      systab = ''
        %daily,nice(7) * 0-7 ${pkgs.findutils}/bin/updatedb > /dev/null 2>&1
        %daily,nice(7) * 0-7 ${pkgs.nix-index}/bin/nix-index > /dev/null 2>&1
      '';
    };
    incron.enable = true;
    locate = {
      enable = true;
      interval = "3:00";
      package = pkgs.plocate;
      localuser = null; # silences warning about plocate not supporting option
      pruneBindMounts = true;
      pruneNames = [ ".bzr" ".git" ".hg" ".svn" ".pijul" ".stfolder" "$RECYCLE.BIN" ".Trashes" "node_packages" ".snapshots" ];
      prunePaths = [ "/tmp" "/var/tmp" "/var/cache" "/var/lock" "/var/run" "/var/spool" "/nix/store" "/nix/var/log/nix" ] ;
    };
    #postgresql = {
    #  enable = false;
    #  extraPlugins = with config.services.postgresql.package.pkgs; [ 
    #    age # graph db
    #    pg_repack # migration tool
    #    pgtap # unit test tool
    #    pgjwt # JWT impl for nginx-less apps
    #    plv8 # v8 js engine
    #    postgis # maps
    #    rum # full text search
    #  ];
    #  package = pkgs.postgresql_15; # must match major version of current openbsd release; currently, v15 (OpenBSD 7.4, circa 2023-12-29)
    #};
    postfix.enable = true;
    printing = {
       enable = true;
       drivers = [ pkgs.gutenprint pkgs.gutenprintBin ];
    };
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };
    rpcbind.enable = true; # NFS à la carte
  };
  programs = {
    adb.enable = true;
    command-not-found.enable = false; # needed by nix-index when enableBashIntegration is active (defaults to true)
    git.enable = true;
    nix-ld.enable = true;
    nix-index.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
  networking.extraHosts = ''
100.100.65.126     bowsprit.fleshcassette.net bowsprit.localdomain bowsprit
100.67.46.74       lain.fleshcassette.net lain.localdomain lain
100.67.196.97      fourcade.fleshcassette.net fourcade.localdomain fourcade
100.92.3.41        alynda.fleshcassette.net alynda.localdomain alynda
100.102.187.120    sopwith.fleshcassette.net sopwith.localdomain sopwith
100.69.208.95      sec.fleshcassette.net sec.localdomain sec fleshcassette hackflesh
'';

  users = {
    users.tss.group = "tss";
    groups.tss = {};
  };
}
