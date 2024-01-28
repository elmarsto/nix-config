{ config, pkgs, lib, ... }:
let
  weztermLua = pkgs.writeText "wezterm" ''
    -- Pull in the wezterm API
    local wezterm = require 'wezterm'

    -- This table will hold the configuration.
    local c = {}

    -- In newer versions of wezterm, use the config_builder which will
    -- help provide clearer error messages
    if wezterm.config_builder then
      c = wezterm.config_builder()
    end

    -- This is where you actually apply your config choices

    -- For example, changing the color scheme:
    c.color_scheme = 'Tomorrow Night'
    c.xcursor_theme = 'Adwaita'
    c.font = wezterm.font 'Monaspace Argon'
    c.harfbuzz_features = { "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08", "calt", "dlig" }
    c.font_size = 14
    c.font_rules = {
      {
        underline = 'Single',
        font = wezterm.font { family = 'Monaspace Krypton', weight = 'Bold' }
      },
      {
        intensity = 'Half',
        italic = false,
        font = wezterm.font { family = 'Monaspace Argon', weight = 'ExtraLight', style = 'Normal' }
      },
      {
        intensity = 'Normal',
        italic = false,
        font = wezterm.font { family = 'Monaspace Argon', weight = 'Regular', style = 'Normal' }
      },
      {
        intensity = 'Bold',
        italic = false,
        font = wezterm.font { family = 'Monaspace Neon', weight = 'ExtraBold', style = 'Normal' }
      },
      {
        intensity = 'Half',
        italic = true,
        font = wezterm.font { family = 'Monaspace Radon', weight = 'ExtraLight', style = 'Normal' }
      },
      {
        intensity = 'Normal',
        italic = true,
        font = wezterm.font { family = 'Monaspace Radon', weight = 'Regular', style = 'Normal' }
      },
      {
        intensity = 'Bold',
        italic = true,
        font = wezterm.font { family = 'Monaspace Neon', weight = 'ExtraBold', style = 'Italic' }
      },
    }
    c.underline_position = -5
    c.colors = { background = 'rgba(50, 50, 50, 0.8)' }
    c.hide_tab_bar_if_only_one_tab = true
    c.tab_bar_at_bottom = true
    c.use_fancy_tab_bar = false
    c.warn_about_missing_glyphs = false

    -- and finally, return the configuration to wezterm
    return c
  '';
  weztermProseLua = pkgs.writeText "weztermProse" ''
    -- Pull in the wezterm API
    local wezterm = require 'wezterm'

    -- This table will hold the configuration.
    local c = {}

    -- In newer versions of wezterm, use the config_builder which will
    -- help provide clearer error messages
    if wezterm.config_builder then
      c = wezterm.config_builder()
    end

    -- This is where you actually apply your config choices

    -- For example, changing the color scheme:
    c.color_scheme = 'Tomorrow Night'
    c.xcursor_theme = 'Adwaita'
    c.font = wezterm.font 'Monaspace Xenon'
    c.harfbuzz_features = { "ss01=0", "ss02=0", "ss03=0", "ss04=0", "ss05=0", "ss06", "ss07=0", "ss08=0", "calt", "dlig" }
    c.font_size = 21
    c.font_rules = {
      {
        underline = 'Single',
        font = wezterm.font { family = 'Monaspace Krypton', weight = 'Bold' }
      },
      {
        intensity = 'Half',
        italic = false,
        font = wezterm.font { family = 'Monaspace Xenon', weight = 'ExtraLight', style = 'Normal' }
      },
      {
        intensity = 'Normal',
        italic = false,
        font = wezterm.font { family = 'Monaspace Xenon', weight = 'Regular', style = 'Normal' }
      },
      {
        intensity = 'Bold',
        italic = false,
        font = wezterm.font { family = 'Monaspace Argon', weight = 'ExtraBold', style = 'Normal' }
      },
      {
        intensity = 'Half',
        italic = true,
        font = wezterm.font { family = 'Monaspace Radon', weight = 'ExtraLight', style = 'Italic' }
      },
      {
        intensity = 'Normal',
        italic = true,
        font = wezterm.font { family = 'Monaspace Xenon', weight = 'Regular', style = 'Italic' }
      },
      {
        intensity = 'Bold',
        italic = true,
        font = wezterm.font { family = 'Monaspace Xenon', weight = 'ExtraBold', style = 'Italic' }
      },
    }
    c.colors = { background = 'rgba(50, 50, 50, 0.8)' }
    c.underline_position = -5
    c.hide_tab_bar_if_only_one_tab = true
    c.tab_bar_at_bottom = true
    c.use_fancy_tab_bar = false
    c.warn_about_missing_glyphs = false

    -- and finally, return the configuration to wezterm
    return c
  '';
  vimnom = pkgs.writeScriptBin "vimnom" ''
    # murder the alt-<Space> gnome shortcut so vim can have it
    gsettings set org.gnome.desktop.wm.keybindings activate-window-menu []
  '';


in
{
  dconf.enable = true;
  fonts.fontconfig.enable = true;
  home = {
    packages = with pkgs; [
      (google-fonts.override {
        fonts = [
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
      dconf
      gnome.gnome-sound-recorder
      gnome.nautilus
      gnome.adwaita-icon-theme
      gnome.dconf-editor
      gnome.gnome-disk-utility
      gnome.gnome-settings-daemon
      gnome.gnome-tweaks
      gnome.seahorse
      gnomeExtensions.battery-health-charging
      gnomeExtensions.clipboard-indicator
      gnomeExtensions.compiz-windows-effect
      gnomeExtensions.espresso
      gnomeExtensions.gnome-40-ui-improvements
      gnomeExtensions.vitals
      google-chrome
      gsettings-desktop-schemas
      libinput
      libreoffice-fresh
      libsForQt5.okular
      libsecret
      lsix
      notify-desktop
      transmission-gtk
      firefox
      monaspace
      wayland-utils
      wezterm
      wl-clipboard
      xdg-utils
      xorg.xeyes
    ];
    file.".wezterm.lua".source = weztermLua;
    file.".wezterm-prose.lua".source = weztermProseLua; # TODO: some cool thing that opens nvim in pencil mode in a new wezterm with this config

    #RESEARCH: still necessary?
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = 1;
      QT_QPA_PLATFORM = "wayland";
    };
  };
  programs = {
    chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
    };
  };
  services = {
    fusuma = {
      enable = true;
      settings = { };
    };
    gnome-keyring = {
      enable = true;
      components = [ "pkcs11" "secrets" ];
    };
    udiskie = {
      enable = true;
      automount = false; # may help with garmin mess
    };
  };
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita";
    };
  };
  xdg = {
    enable = true;
    userDirs.enable = true;
    mimeApps = {
      enable = true;
      #Associations below copied over from ad-hoc mimeapps.list. TODO: break out into appropriate files.
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
    };
  };
}

