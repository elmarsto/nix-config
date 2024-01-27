{ config, lib, pkgs, modulesPath, ... }: {
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
  # WARNING: do not remove imports thingy, not-detect is important
  imports =
    [
      ./fourcade.backup.nix
      ./fourcade.filesystem.nix
      ./fourcade.graphics.nix
      ./fourcade.kernel.nix
      ./fourcade.network.nix
      ./fourcade.peripherals.nix
      (modulesPath + "/installer/scan/not-detected.nix")
    ];


}
