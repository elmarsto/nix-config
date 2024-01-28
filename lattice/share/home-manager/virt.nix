{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    docker-compose
    lazydocker
    podman
    virt-manager
  ];
}
