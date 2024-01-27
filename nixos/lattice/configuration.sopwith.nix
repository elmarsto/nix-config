# Edit this configuration file to define what should be installed on
{ ... }: {
  imports =
    [
      ./audio.nix
      ./bluetooth.nix
      ./cachix.nix
      ./sopwith.nix
      ./common.nix
      ./users.nix
      ./console.nix
      ./gui.nix
      ./virt.nix
    ];
  system.stateVersion = "22.05"; # Did you read the comment?

}

