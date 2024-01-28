{ config, lib, pkgs, modulesPath, ... }: {
  config = {
      boot = { 
        kernelParams = [
          "iommu=pt"
          "iommu=1"
          "console=ttyS0,115200"
          "console=tty1"
        ];
        initrd = {
          availableKernelModules = [
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
        };
        kernelModules = [
          "dm_crypt"
          "dm_mod"
          "vfio-pci"
        ];
        kernel.sysctl = {
           "kernel.shmmax" = "5368709120";
           "kernel.sysrq" = 1; # fourcade is immobile so this is safe (and convenient :D)
           "vm.min_free_kbytes" = "112640";
        };
      };
  };
}
