{ lib, ... }: let
  sshPort = 22;
  syncthingPort = 22000;
  wireguardPort = 51820;
  syncthingUdpPorts = [ syncthingPort 21027 ]; 
  mdnsPorts = [ 5353 53791 ];
  wwwPorts = [ 80 443 ];
  wgTcpPorts = wwwPorts ++ [sshPort];
  wgUdpPorts = mdnsPorts;
  generalTcpPorts = wgTcpPorts ++ [syncthingPort];
  generalUdpPorts = wgUdpPorts ++ syncthingUdpPorts ++ [wireguardPort];
  
in {
  networking = {
    hostName = "bowsprit";
    hostId = "a0300937"; # first 8 of /etc/machine-id, req for zfs
    networkmanager.enable = true;
    interfaces.wlp0s20f3.useDHCP = true;

    firewall = {
      allowPing = true;
      allowedTCPPorts = generalTcpPorts;
      allowedUDPPorts = generalUdpPorts;
      checkReversePath = "loose";
    };
  };
  services = {
    avahi = {
      enable = true;
      openFirewall = true;
      reflector = true;
      nssmdns = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
        userServices = true;
      };
    };
    tailscale.enable = true;
  };
}

