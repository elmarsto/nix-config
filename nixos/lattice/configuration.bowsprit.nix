# Edit this configuration file to define what should be installed on
{ ... }: {
  imports =
    [
      ./audio.nix
      ./bluetooth.nix
      ./bowsprit.nix
      ./cachix.nix
      ./common.nix
      ./console.nix
      ./gui.nix
      ./users.nix
      ./virt.nix
    ];
  system.stateVersion = "22.05"; # Did you read the comment?

}

