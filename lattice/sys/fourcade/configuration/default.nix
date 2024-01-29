{ pkgs, modulesPath, lib, ... }: {
  boot = { 
   initrd.availableKernelModules = [
     "aesni_intel"
     "ahci"
     "cryptd"
     "nvme"
     "sd_mod"
     "thunderbolt"
     "uas"
     "usb_storage"
     "usbhid"
     "xhci_pci"
   ];
   kernelParams = [
     "iommu=pt"
     "iommu=1"
     "console=ttyS0,115200"
     "console=tty1"
     "hugepagesz=1gib"
     "hugepages=16"
   ];
   kernelModules = [
     "dm_crypt"
     "dm_mod"
     "vfio-pci"
   ];
   kernel.sysctl = {
     "kernel.shmmax" = "5368709120";
     "kernel.sysrq" = 1;
   };
  };
  environment.systemPackages = with pkgs; [
    radeon-profile
    radeontools
    radeontop
    rocmPackages.clr # radeon
    rocmPackages.rocm-thunk # radeon
  ];
  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd
    rocmPackages.rocm-runtime
    amdvlk
  ];
  imports = [
    ./backup.nix
    ./filesystem.nix
  ];
  networking = {
    hostId = "1183aa1f";
    hostName = "fourcade"; 
    networkmanager.enable = false;
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
}
