{ config, lib, pkgs, modulesPath, ... }: let
  credential = builtins.readFile ./secret.fido2luks.id;
in {
  system.stateVersion = "22.05"; # Did you read the comment?
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
      ../audio.nix
      ../bluetooth.nix
      ../cachix.nix
      ../common.nix
      ../console.nix
      ../epson.nix
      ../gui.nix
      ../users.nix
      ../virt.nix
      ../wacom.nix
      ../xbox.nix
      ../yubikey.nix
      ./backup.nix
      ./filesystem.nix
      ./hardware-configuration.nix
      ./network.nix
      ./peripherals.nix
      (modulesPath + "/installer/scan/not-detected.nix")
    ];


}
