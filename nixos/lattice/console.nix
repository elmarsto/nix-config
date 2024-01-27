{ lib, pkgs, ... }: let 
  #fontSize = "12x24";
  fontSize = "16x32";
  #fontSize = "5x8";
  #fontSize = "6x12";
  #fontSize = "8x16";
in {
  i18n.defaultLocale = "en_US.UTF-8";
  services = {
    xserver.xkbOptions = "caps:escape";
    gpm.enable = true;
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
    logind.extraConfig = ''
      HandlePowerKey=ignore
    '';
  }; 
  security.doas = {
    extraRules = [
      {
        runAs = "root";
        groups = [ "wheel" ];
        noPass = true;
        keepEnv = true;
        cmd = "systemctl";
        args = [ "stop" "gpm" ];
      }
      {
        runAs = "root";
        groups = [ "wheel" ];
        noPass = true;
        keepEnv = true;
        cmd = "systemctl";
        args = [ "start" "gpm" ];
      }
    ];
  };
  console = {
    useXkbConfig = true; # pairs with xserver.xkbOptions above to fuck up that capslock
    earlySetup = true;
    font = "${pkgs.spleen}/share/consolefonts/spleen-${fontSize}.psfu";
    packages = with pkgs; [ spleen ];
    colors = [ "002b36" "dc322f" "859900" "b58900" "268bd2" "d33682" "2aa198" "eee8d5" "002b36" "cb4b16" "586e75" "657b83" "839496" "6c71c4" "93a1a1" "fdf6e3" ];
  };
}
