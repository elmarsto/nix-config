{ pkgs, ... }: {
  security.pam = {
    services = {
      #login.unixAuth = false;
      #gdm-autologin.unixAuth = false;
      #gdm-launch-environment.unixAuth = false;
      #gdm-password.unixAuth = false;
      #sshd.unixAuth = false; # yep
      #doas.unixAuth = false;
      #su.unixAuth = false;
    };

    yubico = {
      enable = true;
      control = "sufficient";
      mode = "challenge-response";
      challengeResponsePath = "/var/yubico";
    };
  };
  services = {
    udev.packages = [ pkgs.yubikey-personalization ];
    pcscd.enable = true;
  };
}
