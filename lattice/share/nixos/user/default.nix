{ pkgs, ... }: let
  authorizedKeyFiles = [
    ./users/id_fourcade.pub
    ./users/id_bowsprit.pub
    ./users/id_lain.pub
    ./users/id_sopwith.pub
  ];
 in {
  nix.settings.trusted-users = [ "root" "lattice" ];
  users.users = {
    root.openssh.authorizedKeys.keyFiles = authorizedKeyFiles;
    lattice = {
      createHome = false;
      isNormalUser = true;
      openssh.authorizedKeys.keyFiles = authorizedKeyFiles;
      extraGroups = [
        "adbusers"
        "adm"
        "audio"
        "cdrom"
        "disk"
        "docker"
        "doas"
        "dialout"
        "flatpak"
        "input"
        "libvirtd"
        "lp"
        "podman"
        "qemu-libvirtd"
        "render"
        "scanner"
        "systemd-journal"
        "video"
        "wheel"
      ];
    };
  };
  security = {
    doas.extraRules = [
      {
        runAs = "root";
        groups = [ "wheel" ];
        noPass = false;
        keepEnv = false;
      }
    ];
    polkit.adminIdentities = [ "unix-user:lattice" ];
  };
  services = {
    locate.prunePaths = [ "/home/lattice/.mozilla" "/home/lattice/.local" "/home/lattice/.cache" "/home/lattice/.thunderbird"  ];
  };
}
