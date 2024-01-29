{ pkgs,  ... }: {
  hardware.openrazer = {
    enable = true;
    devicesOffOnScreensaver = true;
  }; 
  services.input-remapper = {
    enable = true;
    enableUdevRules = true; 
  };
}
