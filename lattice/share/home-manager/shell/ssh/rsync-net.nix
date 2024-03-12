{
  config,
  pkgs,
  ...
}: {
  programs.ssh.matchBlocks = {
    rsync-net = {
      forwardAgent = false;
      hostname = "fm1890.rsync.net";
      user = "fm1890";
      identityFile = "~/.ssh/id_ed25519_sk";
    };
  };
}
