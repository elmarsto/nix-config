{ lib, config, ... }:
let
in
{
  imports = [
    ./common.nix
    ./audio.nix
    ./cloud.nix
    ./comms.nix
    ./data.nix
    ./dev.nix
    ./gui.nix
    ./mail.nix
    ./nix.nix
    ./shell.nix
    ./ssh.nix
    ./text.nix
    ./vcs.nix
    ./video.nix
    ./virt.nix
    ./visual.nix
  ];
  config = {
    home = {
      username = "lattice";
      homeDirectory = "/home/lattice";
    };
    lattice = {
      spool = "/var/mail/lattice";
      gui.enable = true;
      vcs = {
        email = "315987+elmarsto@users.noreply.github.com";
        name = config.home.username;
      };
    };
  };
}
