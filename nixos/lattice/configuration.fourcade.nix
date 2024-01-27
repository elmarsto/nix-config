{ pkgs, ... }: {
  imports =
    [
      ./audio.nix
      ./bluetooth.nix
      ./cachix.nix
      ./common.nix
      ./console.nix
      ./fourcade.nix
      ./gui.nix
      ./users.nix
      ./virt.nix
    ];
  system.stateVersion = "22.05"; # Did you read the comment?
}
