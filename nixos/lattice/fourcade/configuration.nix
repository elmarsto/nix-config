{ pkgs, modulesPath, lib, ... }: {
  system.stateVersion = "22.05";
  config = {
      boot = {
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
        kernelParams = [
          "hugepagesz=1gib" "hugepages=16"
          "console=ttyS0,115200"
          "console=tty1"
        ];
      };
      powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
      services.fwupd.enable = true;
      hardware.cpu.amd.updateMicrocode = true;
  };
  imports =
    [
      ../audio.nix
      ../backup.nix
      ../bluetooth.nix
      ../cachix.nix
      ../common.nix
      ../console.nix
      ../epson.nix
      ../gui.nix
      ../rng.nix
      ../users.nix
      ../virt.nix
      ../wacom.nix
      ../xbox.nix
      ../yubikey.nix
      ./backup.nix
      ./filesystem.nix
      ./graphics.nix
      ./kernel.nix
      ./network.nix
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
}
