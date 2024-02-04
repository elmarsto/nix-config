{pkgs, config, ... }:
{
  boot = {
    kernelModules = [ "kvm" "kvm-amd" "kvm-intel" "vfio-pci" ];
    kernel.sysctl = { "vm.hugetlb_shm_group" = "301"; };
  };
  environment.systemPackages = with pkgs; [ virt-manager podman ];
  programs.dconf.enable = true; #needed by virt-manager
  services.flatpak.enable = true;
  virtualisation = {
    libvirtd.enable = true;
    docker.enable = false;  
    podman = {
     enable = true;
     enableNvidia = true;
     dockerCompat = true;
     dockerSocket.enable = true;
     defaultNetwork.settings.dns_enabled = true;
     defaultNetwork.settings.dnsname_enabled = true;
    };
    spiceUSBRedirection.enable = true;
  };
  xdg.portal.enable = true;
}
