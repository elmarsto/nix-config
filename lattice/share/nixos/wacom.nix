{ pkgs,  ... }: let
in {
  services = {
    xserver = {
      wacom.enable = true;
      libinput = {
        enable = true;
        touchpad.naturalScrolling = false;
        touchpad.tapping = true;
        touchpad.disableWhileTyping = true;
        touchpad.horizontalScrolling = false;
      };
    };
  };
}
