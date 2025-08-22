{
  lib,
  pkgs,
  ...
}: {
  boot.kernel.sysctl."net.ipv4.conf.all.forwarding" = true;
  environment.systemPackages = [pkgs.tailscale];
  networking = {
    nat.enable = true;
  };
  programs = {
    kdeconnect.enable = true;
  };
  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
    openssh = {
      enable = true;
      extraConfig = ''
        AllowAgentForwarding yes
      '';
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        X11Forwarding = false;
      };
    };
    tailscale = {
      enable = true;
      authKeyFile = "/run/secrets/tailscale_key";
      openFirewall = true;
      useRoutingFeatures = "both";
    };
  };
}
