{ lib, config, lattice, ... }:  {
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