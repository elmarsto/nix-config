{pkgs, ...}: let
  mdMime = pkgs.writeText "text-markdown.xml" ''
    <?xml version="1.0" encoding="UTF-8"?>
    <mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
      <mime-type type="text/markdown">
        <comment>Markdown</comment>
        <glob pattern="*.md"/>
      </mime-type>
    </mime-info>
  '';
in {
  home = {
    packages = with pkgs; [
      neovide
      figma-linux
      cheese
      krita
      comby # syntax-aware (AST?) search/replace CLI
      zls # zig lsp
    ];
    services = {
      gnome-keyring = {
        enable = true;
        components = ["pkcs11" "secrets"];
      };
      pueue = {
        enable = true;
        settings.daemon.default_parallel_tasks = 4;
      };
      recoll = {
        enable = true;
        settings = {
          loglevel = 5;
          nocjk = true;
          "skippedNames+" = ["node_modules" "target" "result" ".git" "*.iso"];
          topdirs = [
            "~/Audio"
            "~/Calibre Library"
            "~/DCIM"
            "~/Documents"
            "~/Downloads"
            "~/Music"
            "~/Pictures"
            "~/Videos"
            "~/code"
            "~/too-many-secrets"
            "~/work"
          ];
        };
      };
      udiskie = {
        enable = true;
        automount = false; # may help with garmin mess
      };
    };
    xdg = {
      configFile = {
        "vale/vale.ini".text = ''
          StylesPath = styles
          MinAlertLevel = suggestion
          Packages = proselint
          [*]
          BasedOnStyles = Vale, proselint
        '';
        "vale/styles/.ignore".text = "";
      };
      dataFile."../bin/vale-ls".source = ./vale-ls;
      mimeApps = {
        defaultApplications = {
          "text/markdown" = ["firefox.desktop"];
        };
      };
      dataFile."mime/packages/text-markdown.xml".source = mdMime;
      desktopEntries = {
        glow = {
          name = "Glow";
          genericName = "Markdown previewer";
          exec = ''${pkgs.alacritty}/bin/alacritty -e "${pkgs.glow}/bin/glow %U"'';
          mimeType = ["text/markdown"];
        };
      };
    };
  };
}
