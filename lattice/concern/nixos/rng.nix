{ pkgs,  ... }:
let
  rngd = "${pkgs.rng-tools}/bin/rngd";

  rnger = pkgs.writeShellScript "rnger" ''
    # TODO parameterize
    ${rngd} -r /dev/serial/by-id/usb-Ubld_Electronics_LLC_TrueRNGpro_0000231D-if00 -x rdrand -x jitter -d
'';
in {
  services.udev.extraRules = ''
    SUBSYSTEM=="tty", ATTRS{product}=="TrueRNG", SYMLINK+="hwrng", RUN+="${pkgs.coreutils}/bin/stty raw -echo -ixoff -F /dev/%k speed 3000000"
    ATTRS{idVendor}=="04d8", ATTRS{idProduct}=="f5fe", ENV{ID_MM_DEVICE_IGNORE}="1"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0666"
  '';
  security = {
    doas = {
      extraRules = [
        { 
          groups = [ "wheel" ];
          cmd = "${rngd}";
          noPass = true;
          keepEnv = false;
        }
      ];
    };
    sudo = {
      extraConfig = ''
        %wheel  ALL=(ALL:ALL)   NOPASSWD: ${rngd}
      '';
    };
  };
  systemd.services.rnger = {
    description = "Rnger: Activate RNG daemon and hardware";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${rnger}";
      Type = "forking";
      User = "root";
      Restart = "on-failure";
      StartLimitIntervalSec = 500;
      StartLimitBurst = 5;
      RestartSec = "5s";
    };
  };
}
