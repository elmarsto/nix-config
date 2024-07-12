{
  config,
  lib,
  pkgs,
  ...
}: {
  networking = {
    hostName = "bowsprit";
    hostId = "a0300937"; # first 8 of /etc/machine-id, req for zfs
    networkmanager.enable = true;
    interfaces.wlp0s20f3.useDHCP = true;
  };
  imports = [./hardware-configuration.nix];
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
  '';
  services.borgbackup.jobs.bowsprit = {
    doInit = true;
    paths = ["/home/lattice"];
    repo = "fm1890@fm1890.rsync.net:bowsprit";
    exclude = [
      "**/.cache"
      "/home/lattice/code"
      "/home/lattice/Downloads"
      "/home/lattice/.mozilla"
    ];
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /etc/secrets/borgbackup-rsync.net";
    };
    environment = {
      BORG_RSH = "ssh -i /etc/secrets/id_rsync.net";
    };
    compression = "auto,lzma";
    startAt = "hourly";
  };
}
