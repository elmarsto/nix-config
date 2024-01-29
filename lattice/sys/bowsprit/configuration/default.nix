{ config, lib, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];
  networking = {
    hostName = "bowsprit";
    hostId = "a0300937"; # first 8 of /etc/machine-id, req for zfs
    networkmanager.enable = true;
    interfaces.wlp0s20f3.useDHCP = true;
  };
  udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
  '';
}
