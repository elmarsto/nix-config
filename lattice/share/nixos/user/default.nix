{pkgs, ...}: let
  # TODO: put these in a separate flake and refer to it by URL as a flake input
  authorizedKeyFiles = [
    ./id_fourcade.pub
    ./id_bowsprit.pub
    ./id_sopwith.pub
  ];
in {
  nix.settings.trusted-users = ["root" "lattice"];
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
    polkit.adminIdentities = ["unix-user:lattice"];
    doas.extraRules = [
      {
        users = ["lattice"];
        persist = true;
      }
    ];
  };
  services = {
    locate.prunePaths = ["/home/lattice/.mozilla" "/home/lattice/.local" "/home/lattice/.cache" "/home/lattice/.thunderbird"];
  };
}
