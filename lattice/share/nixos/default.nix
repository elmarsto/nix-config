{
  lib,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nixVersions.stable;
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
  imports = [
    ./backup.nix
    ./console.nix
    ./peripheral
    ./gui.nix
    ./user
    ./network.nix
    ./virt.nix
  ];
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = "1048576";
      "vm.min_free_kbytes" = "112640";
    };
  };
  environment.systemPackages = with pkgs; [
    # tracee RESEARCH: what thisis and how to use it
    appimage-run
    bcc
    below
    comma
    coreutils
    cpuid
    ethtool
    exfat
    findutils
    linuxKernel.packages.linux_libre.perf
    linuxKernel.packages.linux_libre.turbostat
    lsof
    msr-tools
    ncdu
    nethogs
    numactl
    nvd
    perf-tools
    procps
    sysstat
    sysz # systemctl tui
    tcpdump
    termshark
    tiptop
    trace-cmd
    traceroute
    tshark
  ];
  hardware = {
    cpu.intel.updateMicrocode = true;
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = lib.mkDefault true;
    pulseaudio.enable = false;
  };
  i18n.defaultLocale = "en_US.UTF-8";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  programs = {
    adb.enable = true;
    command-not-found.enable = false;
    git.enable = true;
    nix-ld.enable = true;
    nix-index.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
  security = {
    doas.enable = true;
    pam = {
      sshAgentAuth.enable = true;
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
    polkit.adminIdentities = ["unix-group:wheel"];
    protectKernelImage = true;
    sudo.enable = false;
    rtkit.enable = true;
    tpm2.enable = true;
    tpm2.abrmd.enable = true;
  };
  services = {
    acpid.enable = true;
    fcron = {
      enable = true;
      systab = ''
        %daily,nice(7) * 0-7 ${pkgs.findutils}/bin/updatedb > /dev/null 2>&1
        %daily,nice(7) * 0-7 ${pkgs.nix-index}/bin/nix-index > /dev/null 2>&1
      '';
    };
    fwupd.enable = true;
    incron.enable = true;
    locate = {
      enable = true;
      interval = "3:00";
      package = pkgs.plocate;
      pruneBindMounts = true;
      pruneNames = [".bzr" ".git" ".hg" ".svn" ".pijul" ".stfolder" "$RECYCLE.BIN" ".Trashes" "node_packages" ".snapshots"];
      prunePaths = ["/tmp" "/var/tmp" "/var/cache" "/var/lock" "/var/run" "/var/spool" "/nix/store" "/nix/var/log/nix"];
    };
    postfix.enable = true;
  };
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
    stateVersion = "22.05";
  };
  time.timeZone = "America/Vancouver";
  users = {
    users.tss.group = "tss";
    groups.tss = {};
  };
}
