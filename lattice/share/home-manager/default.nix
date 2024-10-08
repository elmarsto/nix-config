{ ... }: {
  imports = [
    ./audio.nix
    ./comms.nix
    ./gui
    ./mail
    ./neovim
    ./shell
    ./linux.nix
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
