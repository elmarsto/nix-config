{ config, lib, pkgs, modulesPath, ... }: let
  credential = builtins.readFile ./secret.fido2luks.id;
in {
  config = {
      hardware = {
        nvidia.modesetting.enable = true;
        opengl = {
          enable = true;
          driSupport = true;
          driSupport32Bit = true;
          extraPackages = with pkgs; [ ];
        };
      };
      virtualisation.docker.enableNvidia = true;
      services.xserver = {
        enable = true;
        videoDrivers = [ "nvidia" ];
        displayManager = {
          defaultSession = "gnome";
          gdm.enable = true;
        };
        desktopManager.gnome.enable = true;
      };
      boot = {
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
        kernel.sysctl = {
          "kernel.sysrq" = 0; # safer for laptop to disable sysrq
        };
        kernelParams = [
          "console=ttyS0,115200"
          "console=tty1"
        ];
      };
      hardware.cpu.amd.updateMicrocode = true;
  };
  imports =
    [
      ./sopwith.backup.nix
      ./sopwith.network.nix
      ./sopwith.filesystem.nix
      ./sopwith.peripherals.nix
      ./hardware-configuration.sopwith.nix
      # WARNING: do not remove next line because not-detected.nix is important
      (modulesPath + "/installer/scan/not-detected.nix")
    ];


}
