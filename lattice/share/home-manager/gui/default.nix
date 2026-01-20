{pkgs,  ...}: {
  dconf.enable = true;
  fonts.fontconfig.enable = true;
  home = {
    packages = with pkgs; [
      (google-fonts.override {
        fonts = [
          "Oxanium"
          "Raleway"
          "Zen Loop"
        ];
      })
      baobab
      bitwarden-desktop
      dconf
      glaxnimate
      google-chrome
      insomnia
      jetbrains-mono
      kando
      kdePackages.kcolorchooser
      kdePackages.kdenlive
      libinput
      libreoffice-fresh
      lsix
      monaspace
      monolith
      mtr-gui
      nerd-fonts.monaspace
      notify-desktop
      unstable.obsidian
      qjournalctl
      qcad
      roboto
      roboto-mono
      roboto-serif
      roboto-slab
      source-code-pro
      source-sans
      source-serif
      sqlitebrowser
      sublime-merge
      udev-gothic
      vscode
      code-cursor
      wayland-utils
      wezterm
      wl-clipboard
      xdg-utils
      xorg.xeyes
      yarr
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
        "application/xhtml+xml" = "google-chrome.desktop";
        "audio/mpeg" = "mpv.desktop";
        "audio/wav" = "mpv.desktop";
        "default-web-browser" = "google-chrome.desktop";
        "text/html" = "google-chrome.desktop";
        "video/mp4" = "mpv.desktop";
        "video/quicktime" = "mpv.desktop";
        "video/webm" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";
        "x-scheme-handler/http" = "google-chrome.desktop";
        "x-scheme-handler/https" = "google-chrome.desktop";
        "x-scheme-handler/sms" = "org.gnome.Shell.Extensions.GSConnect.desktop";
        "x-scheme-handler/tel" = "org.gnome.Shell.Extensions.GSConnect.desktop";
      };
      enable = true;
    };
    userDirs.enable = true;
  };
}
