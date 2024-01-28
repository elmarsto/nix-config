{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    cachix
    comma
    manix
    nix-doc
    nurl
  ];
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };
    nix-index = {
      enable = true;
      enableBashIntegration = true;
    };
  };
  services = {
    lorri.enable = true;
  };
}
