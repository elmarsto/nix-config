{
  config,
  pkgs,
  ...
}: {
  programs.ssh.matchBlocks = {
    sc = {
      forwardAgent = true;
      hostname = "saccades.tail6e61.ts.net";
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
    saccades = {
      forwardAgent = true;
      hostname = "saccades.ca";
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
  };
}
