{ pkgs,  ... }: let
in {
  services.xserver = {
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = false;
        tapping = true;
        disableWhileTyping = true;
        horizontalScrolling = false;
      };
    };
    wacom.enable = true;
  };
}
