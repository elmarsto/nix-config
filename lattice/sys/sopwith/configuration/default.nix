{ config, lib, pkgs, modulesPath, ... }: {
  hardware.nvidia.modesetting.enable = true;
  virtualisation.docker.enableNvidia = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  networking = {
    hostName = "sopwith";
    hostId = "ea33110c"; # first 8 of /etc/machine-id, req for zfs
    networkmanager.enable = true;
    interfaces.wlp3s0.useDHCP = true;
  };
  imports = [ ./hardware-configuration.nix ];
}
