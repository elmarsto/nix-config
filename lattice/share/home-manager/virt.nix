{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    podman-compose
    lazydocker
    runc
    virt-manager
  ];
}
