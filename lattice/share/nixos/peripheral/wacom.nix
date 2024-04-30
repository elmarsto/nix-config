{pkgs, ...}: let
in {
  services = {
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = false;
        tapping = true;
        disableWhileTyping = true;
        horizontalScrolling = false;
      };
    };
    xserver = {
      wacom.enable = true;
    };
  };
}
