{
  config,
  pkgs,
  lib,
  ...
}: {
  dconf.enable = true;
  fonts.fontconfig.enable = true;
  home = {
    packages = with pkgs; [
      bitwarden
      dconf
      gnome.adwaita-icon-theme
      gnome.dconf-editor
      gnome.gnome-disk-utility
      gnome.gnome-settings-daemon
      gnome.gnome-sound-recorder
      gnome.gnome-tweaks
      gnome.nautilus
      gnome.seahorse
      gnomeExtensions.battery-health-charging
      gnomeExtensions.clipboard-indicator
      gnomeExtensions.compiz-windows-effect
      gnomeExtensions.espresso
      gnomeExtensions.gnome-40-ui-improvements
      gnomeExtensions.vitals
      (google-fonts.override {
        fonts = [
          "Oxanium"
          "Raleway"
          "Roboto Slab"
          "Roboto Mono"
          "Roboto Sans"
          "Roboto Serif"
          "Source Code Pro"
          "Source Sans"
          "Source Serif"
          "Zen Loop"
        ];
      })
      (nerdfonts.override { fonts = [ "VictorMono" "Monaspace" ]; })
      google-chrome
      gsettings-desktop-schemas
      libinput
      libreoffice-fresh
      lsix
      monaspace
      notify-desktop
      qjournalctl
      wayland-utils
      wezterm
      wl-clipboard
      xdg-utils
      xorg.xeyes
      #unstable.sublime4
      unstable.sublime-merge
    ];
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = 1;
      QT_QPA_PLATFORM = "wayland";
    };
  };
  imports = [./wezterm.nix];
  programs = {
    chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
    };
    firefox.enable = true;
  };
  services.fusuma = {
    enable = true;
    settings = {};
  };
  xdg = {
    enable = true;
    mimeApps = {
      defaultApplications = {
        "application/epub+zip" = "foliate.desktop";
        "application/pdf" = "okular.desktop";
        "application/rss+xml" = "org.gabmus.gfeeds.desktop";
        "application/vnd" = "code.desktop";
        "application/x-code-insiders-workspace" = "code.desktop";
        "application/x-code-workspace" = "code.desktop";
        "application/xhtml+xml" = "firefox.desktop";
        "audio/mpeg" = "mpv.desktop";
        "audio/wav" = "mpv.desktop";
        "default-web-browser" = "firefox.desktop";
        "text/html" = "firefox.desktop";
        "video/mp4" = "mpv.desktop";
        "video/quicktime" = "mpv.desktop";
        "video/webm" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/sms" = "org.gnome.Shell.Extensions.GSConnect.desktop";
        "x-scheme-handler/tel" = "org.gnome.Shell.Extensions.GSConnect.desktop";
      };
      enable = true;
    };
    userDirs.enable = true;
  };
}
