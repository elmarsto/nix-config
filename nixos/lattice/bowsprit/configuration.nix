{ config, lib, pkgs, modulesPath, ... }: let
  credential = builtins.readFile ./secret.fido2luks.id;
in {
  system.stateVersion = "22.05"; # Did you read the comment?
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
      ../audio.nix
      ../bluetooth.nix
      ../cachix.nix
      ../common.nix
      ../console.nix
      ../gui.nix
      ./hardware-configuration.nix
      ./network.nix
      ../users.nix
      ../virt.nix
      ../backup.nix
      ../yubikey.nix
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

}
