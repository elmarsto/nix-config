{ config, pkgs, ... }: { programs.ssh.matchBlocks = {
  fleshy = {
    # fleshcassette.net
    forwardAgent = true;
    hostname = "sec.fleshcassette.net";
    user = "lattice";
    identityFile = "~/.ssh/id_ed25519_sk";
    localForwards = [
      {
        # syncthing admin
        bind.port = 8385;
        host.port = 8384;
        host.address = "127.0.0.1";
      }
    ];
  };
  hackflesh = {
    forwardAgent = true;
    hostname = "sec.fleshcassette.net";
    user = "root";
    identityFile = "~/.ssh/id_ed25519_sk";
    localForwards = [
      {
        # workspace-portal
        bind.port = 8385;
        host.port = 8384;
        host.address = "127.0.0.1";
      }
    ];
  };
};}

