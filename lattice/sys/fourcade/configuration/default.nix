{ pkgs, modulesPath, lib, ... }: {
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
  hardware = {
    cpu.amd.updateMicrocode = true;
     # important (https://discourse.nixos.org/t/whats-the-rationale-behind-not-detected-nix/5403     
    enableRedistributableFirmware = lib.mkDefault true;
  };
  system.stateVersion = "22.05";
  imports =
    [
      ./backup.nix
      ./filesystem.nix
      ./graphics.nix
      ./kernel.nix
      ./network.nix
    ];
}
