{pkgs, ...}: {
  home.packages = with pkgs; [
    docker-compose
    lazydocker
    runc
    virt-manager
  ];
}
