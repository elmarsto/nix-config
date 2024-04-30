{
  pkgs,
  config,
  ...
}: {
  boot = {
    kernelModules = ["kvm" "kvm-amd" "kvm-intel" "vfio-pci"];
    kernel.sysctl = {"vm.hugetlb_shm_group" = "301";};
  };
  environment.systemPackages = with pkgs; [virt-manager docker];
  programs.dconf.enable = true; #needed by virt-manager
  services.flatpak.enable = true;
  virtualisation = {
    libvirtd.enable = true;
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    # podman = {
    #   enable = true;
    #   dockerCompat = true;
    #   dockerSocket.enable = true;
    #   defaultNetwork.settings =  {
    #     dns_enabled = true;
    #     dnsname_enabled = true;
    #   };
    # };
    spiceUSBRedirection.enable = true;
  };
  xdg.portal.enable = true;
}
