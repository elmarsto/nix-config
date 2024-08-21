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
      #bitwarden
      dconf
      jetbrains-mono
      udev-gothic
      (google-fonts.override {
        fonts = [
          "Oxanium"
          "Raleway"
          "Zen Loop"
        ];
      })
      roboto
      roboto-slab
      roboto-mono
      roboto-serif
      source-sans
      source-code-pro
      source-serif
      (nerdfonts.override {fonts = ["VictorMono" "Monaspace"];})
      google-chrome
      sqlitebrowser
      ladybird
      monolith
      kcolorchooser
      insomnia
      libinput
      libreoffice-fresh
      lsix
      mtr-gui # gui for mtr network diagnostics tool
      monaspace
      notify-desktop
      obsidian
      qjournalctl
      wayland-utils
      wezterm
      wl-clipboard
      xdg-utils
      xorg.xeyes
      sublime-merge
      kdenlive
      glaxnimate # for kdenlive
      #lapce
      vscode
      zed-editor
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
    };
    firefox.enable = true;
  };
  services = {
    fusuma = {
      enable = true;
      settings = {};
    };
    kdeconnect = {
      enable = true;
      indicator = true;
    };
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
