{ lib, pkgs, ... }: {
  boot.kernel.sysctl."net.ipv4.conf.all.forwarding" = true;
  environment.systemPackages = [ pkgs.tailscale ];
  networking = {
    extraHosts = ''
      100.100.65.126     bowsprit.fleshcassette.net bowsprit.localdomain bowsprit
      100.67.196.97      fourcade.fleshcassette.net fourcade.localdomain fourcade
      100.102.187.120    sopwith.fleshcassette.net sopwith.localdomain sopwith
      100.69.208.95      sec.fleshcassette.net sec.localdomain sec fleshcassette hackflesh
    '';
    nat.enable = true;
  };
  services = {
    avahi = {
      enable = true;
      nssmdns = true;
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
    tailscale =  {
      enable = true;
      authKeyFile = "/run/secrets/tailscale_key";
      openFirewall = true;
      useRoutingFeatures = "both";
    };
  };
}
