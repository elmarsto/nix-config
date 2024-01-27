{ config, lib, pkgs, modulesPath, ... }: let
  credential = builtins.readFile ./secret.fido2luks.id;
in {
  config = {
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
      programs.xwayland.enable = true;
      services.xserver = {
        enable = true;
        displayManager = {
          defaultSession = "gnome";
          gdm = {
            enable = true;
            wayland = true;
          };
        };
        desktopManager.gnome.enable = true;
      };
      hardware.cpu.intel.updateMicrocode = true;
  };
  imports =
    [
      ./bowsprit.backup.nix
      ./bowsprit.network.nix
      ./bowsprit.filesystem.nix
      ./bowsprit.peripherals.nix
      ./hardware-configuration.bowsprit.nix
      # WARNING: do not remove next line because not-detected.nix is important
      (modulesPath + "/installer/scan/not-detected.nix")
    ];


}
