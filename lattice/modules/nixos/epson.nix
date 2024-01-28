{ pkgs, ... }: {
  hardware.sane = {
    enable = true;
    extraBackends = with pkgs; [ utsushi ];
  };
  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint pkgs.gutenprintBin pkgs.epson-escpr ];
    browsing = true;
    allowFrom = ["all"];
    defaultShared = true;
  };
}
