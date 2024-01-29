{ lib, pkgs, ... }:  {
  environment.systemPackages = with pkgs; [
    clinfo
    openxr-loader
    xrgears
    vulkan-tools
    vulkan-validation-layers
  ];
  fonts = {
    enableDefaultPackages = true;
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "Noto Sans Mono" ];
    };
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
    ];
  };
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
  };
  nixpkgs.config.firefox.enableGnomeExtensions = true;
  programs.xwayland.enable = true;
  services =  {
    pipewire = {
      alsa = {
        enable = true;
        support32Bit = true;
      };
      enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
    xserver = {
      desktopManager.gnome.enable = true;
      displayManager = {
        defaultSession = "gnome";
        gdm = {
          enable = true;
          wayland = true;
        };
      };
      enable = true;
      layout = "us";
      xkbOptions = "caps:escape"; #sanity
      xkbVariant = "";
    };
  };
  sound.enable = true;
}
