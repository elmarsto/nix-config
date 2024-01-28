{ config, lib, pkgs, modulesPath, ... }: {
  config = {
      hardware = {
        opengl = {
          driSupport = true;
          driSupport32Bit = true;
          extraPackages = with pkgs; [
            rocm-opencl-icd
            rocmPackages.rocm-runtime
            amdvlk
          ];
        };
      };
      services.xserver = {
        enable = true;
        videoDrivers = [ "amdgpu" ];
        displayManager = {
          defaultSession = "gnome";
          gdm = {
            enable = true;
            wayland = true;
          };
        };
        desktopManager.gnome.enable = true;
      };        
      programs.xwayland.enable = true;
      environment.systemPackages = with pkgs; [
        clinfo
        openxr-loader
        xrgears
        radeon-profile
        radeontools
        radeontop
        rocmPackages.clr # radeon
        rocmPackages.rocm-thunk # radeon
        vulkan-tools
        vulkan-validation-layers
       ];
  };
}
