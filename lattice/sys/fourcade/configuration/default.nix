{pkgs, ...}: {
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
  ];
  hardware = {
    #amdgpu.opencl.enable = true;
    graphics.extraPackages = with pkgs; [
      #rocm-opencl-icd
      #rocmPackages.rocm-runtime
      amdvlk
    ];
  };
  services = {
    ollama = {
      package = pkgs.ollama-rocm;
      acceleration = "rocm";
      enable = true;
      loadModels = ["llama3.3"];
    };
    nextjs-ollama-llm-ui = {
      enable = true;
      port = 33000;
    };
  };
  imports = [
    ./backup.nix
    ./filesystem.nix
  ];
  networking = {
    hostId = "1183aa1f";
    hostName = "fourcade";
    networkmanager.enable = true;
    interfaces.wlp4s0.useDHCP = true;
  };
  services.xserver.videoDrivers = ["amdgpu"];
}
