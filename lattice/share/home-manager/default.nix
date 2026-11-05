{ ... }: {
  imports = [
    ./audio.nix
    ./comms.nix
    ./gui
    ./shell
    ./text.nix
    ./vcs.nix
    ./video.nix
    ./virt.nix
    ./visual.nix
  ];
  home = {
    username = "lattice";
    homeDirectory = "/home/lattice";
  };
}
