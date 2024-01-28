{ lib, config, lattice, ... }: {
  config = {
    home = {
      username = "lattice";
      homeDirectory = "/home/lattice";
    };
    lattice = {
      vcs = {
        email = "315987+elmarsto@users.noreply.github.com";
        name = config.home.username;
      };
    };
  };
}


