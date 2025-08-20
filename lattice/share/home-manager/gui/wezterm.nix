{pkgs, ...}: {
  home = {
    file.".wezterm.lua".source = pkgs.writeText "wezterm" ''
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
      c.font = wezterm.font {
        family = 'Monaspace Krypton',
        harfbuzz_features = { 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'calt', 'liga' }
      }
      c.font_size = 14
      c.font_rules = {
        {
          underline = 'Single',
          font = wezterm.font { family = 'Monaspace Krypton', weight = 'Bold' }
        },
        {
          intensity = 'Half',
          italic = false,
          font = wezterm.font { family = 'Monaspace Krypton', weight = 'ExtraLight', style = 'Normal' }
        },
        {
          intensity = 'Normal',
          italic = false,
          font = wezterm.font { family = 'Monaspace Krypton', weight = 'Regular', style = 'Normal' }
        },
        {
          intensity = 'Bold',
          italic = false,
          font = wezterm.font { family = 'Monaspace Krypton', weight = 'ExtraBold', style = 'Normal' }
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
          font = wezterm.font { family = 'Monaspace Krypton', weight = 'ExtraBold', style = 'Italic' }
        },
      }
      c.underline_position = -5
      c.colors = { background = 'rgba(50, 50, 50, 0.8)' }
      c.hide_tab_bar_if_only_one_tab = false
      c.tab_bar_at_bottom = true
      c.use_fancy_tab_bar = true
      c.warn_about_missing_glyphs = false
      c.launch_menu = {
        {
          args = { 'top' },
        },
        {
          label = 'bash',
          args = { 'bash', '-l' }
        },
        {
          label = 'aichat',
          args = { 'aichat' }
        },
        {
          label = 'yazi',
          args = { 'yazi' }
        }
      }

      -- and finally, return the configuration to wezterm
      return c
    '';
    packages = [pkgs.wezterm];
  };
}
