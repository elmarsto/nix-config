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
    hostName = "sopwith";
    hostId = "ea33110c"; # first 8 of /etc/machine-id, req for zfs
    networkmanager.enable = true;
    interfaces.wlp3s0.useDHCP = true;

    firewall = {
      allowPing = true;
      allowedTCPPorts = generalTcpPorts;
      allowedUDPPorts = generalUdpPorts;
      checkReversePath = "loose";
      interfaces = {
        tailscale0 = { 
          allowedTCPPorts = wgTcpPorts;
          allowedUDPPorts = wgUdpPorts;
        };
      };
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

