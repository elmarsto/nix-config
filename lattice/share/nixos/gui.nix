{
  lib,
  pkgs,
  ...
}: {
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
      serif = ["Noto Serif"];
      sansSerif = ["Noto Sans"];
      monospace = ["Noto Sans Mono"];
    };
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
    ];
  };
  hardware.graphics.enable32Bit = true;
  nixpkgs.config.firefox.enableGnomeExtensions = true;
  programs = {
    xwayland.enable = true;
    dconf.enable = true;
  };
  services = {
    pipewire = {
      alsa = {
        enable = true;
        support32Bit = true;
      };
      enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
    desktopManager = {
      # gnome.enable = true;
      plasma6.enable = true;
    };
    displayManager = {
      defaultSession = "plasma";
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      # gdm = {
      #   enable = true;
      #   wayland = true;
      # };
    };
    xserver = {
      enable = true;
      xkb = {
        options = "caps:escape,compose:ralt"; #sanity
        variant = "";
        layout = "us";
      };
    };
  };
  sound.enable = true;
}
