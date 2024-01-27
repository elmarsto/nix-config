{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    #anbox
    #distrobox
    #dive
    docker-compose
    lazydocker
    podman
    #podman-desktop
    virt-manager
  ];
}
