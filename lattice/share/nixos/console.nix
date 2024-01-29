{ lib, pkgs, ... }: let
  doas-rule = command: {
    args = [ command "gpm" ];
    cmd = "systemctl";
    groups = [ "wheel" ];
    keepEnv = true;
    noPass = true;
    runAs = "root";
  };
in {
  console = {
    colors = [
      "002b36"
      "dc322f"
      "859900"
      "b58900"
      "268bd2"
      "d33682"
      "2aa198"
      "eee8d5"
      "002b36"
      "cb4b16"
      "586e75"
      "657b83"
      "839496"
      "6c71c4"
      "93a1a1"
      "fdf6e3"
    ];
    earlySetup = true;
    font = "${pkgs.spleen}/share/consolefonts/spleen-16x32.psfu";
    packages = with pkgs; [ spleen ];
    useXkbConfig = true; # pairs with xserver.xkbOptions above to fuck up that capslock
  };
  i18n.defaultLocale = "en_US.UTF-8";
  security.doas.extraRules = [
    (doas-rule "start")
    (doas-rule "stop")
  ];
  services = {
    acpid = {
      enable = true;
      logEvents = true;
      powerEventCommands = ''
        systemctl suspend 
      '';
      lidEventCommands = ''
        systemctl suspend 
      '';
    };
    gpm.enable = true;
    logind.extraConfig = ''
      HandlePowerKey=ignore
    '';
    xserver.xkbOptions = "caps:escape";
  }; 
}
