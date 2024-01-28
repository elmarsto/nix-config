{ lib, pkgs, ... }:  {
  nixpkgs.config.firefox.enableGnomeExtensions = true;
  services =  {
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
    '';
    xserver = {
      layout = "us";
      xkbOptions = "caps:escape"; #sanity
      xkbVariant = "";
    };
  };
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      noto-fonts-lgc-plus
      noto-fonts-cjk-serif
      noto-fonts-emoji-blob-bin
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "Noto Sans Mono" ];
      };
    };
  };
}
