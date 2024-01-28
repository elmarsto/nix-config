{pkgs, config, ... }:
{
  boot = {
    # kernelParams = ["hugepagesz=1gib" "hugepagesz=2mib" ]; -- now done per-machine
    kernelModules = [ "kvm" "kvm-amd" "kvm-intel" "vfio-pci" ];
    kernel.sysctl = { "vm.hugetlb_shm_group" = "301"; };
  };
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
  systemd.user.services.xdg-desktop-portal.environment = {
    # (also https://github.com/NixOS/nixpkgs/issues/108855)
    XDG_DESKTOP_PORTAL_DIR = config.environment.variables.XDG_DESKTOP_PORTAL_DIR;
  };

  users.groups = { docker = {} ; };
  services.flatpak.enable = true;
  fileSystems."/hugepages-2MiB" =
    { device = "hugetlbfs";
    fsType = "hugetlbfs";
    options = [ "mode=1770"  "gid=0" "pagesize=2MiB"];
    };
  fileSystems."/hugepages-1GiB" =
    { device = "hugetlbfs";
    fsType = "hugetlbfs";
    options = [ "mode=1770"  "gid=0" "pagesize=1GiB"];
    };
}
