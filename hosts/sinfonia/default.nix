{ config, lib, pkgs, inputs, hostName, ... }:
let
  network = {
    interface = "end0";
    ip = {
      address = "192.168.0.2";
      prefixLength = 24;
    };
    dns = {
      localResolver = "127.0.0.1";
    };
  };

  wg = {
    port = 51820;
    subnet = "10.5.5.0/24";
    clientIp = "10.5.5.2/32";
    endpoint = "wg.phy0.me:${toString wg.port}";
    serverPubKey = "/ko07sTopPxjUJijyKz4dbd5lXGX0qSpQkrvyJB9+QM=";
  };

  ports = {
    web = [ 80 443 ];
  };

  user = {
    name = "glwbr";
    fullName = "Glauber Santana";
    email = "glauber.silva14@gmail.com";
    sshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOw9mnJmXKHKGvkdlSHJ7dFP2XhlKvQbKogHxwBXFg9o";
  };

  allTcpPorts = lib.flatten (lib.attrValues ports);
  allUdpPorts = [ wg.port ];
in
{
  imports = [ ./boot.nix ./hardware.nix ];

  aria.core.users = {
    defaultUserShell = pkgs.zsh;
    users.${user.name} = {
      inherit (user) name fullName email;
      extraGroups = [ "wheel" ];
      useSOPSPassword = true;
      sshKeys = [ user.sshKey ];
    };
  };

  aria.virtualisation.docker = {
    enable = true;
    users = [ user.name ];
  };

  aria.services = {
    adguard.enable = true;
    traefik.enable = true;
  };

  sops.secrets.wireguard = {
    sopsFile = ./secrets.yaml;
    neededForUsers = false;
  };

  networking.wireguard.interfaces.wg0 = {
    ips = [ wg.clientIp ];
    privateKeyFile = config.sops.secrets.wireguard.path;
    listenPort = wg.port;
    peers = [{
      name = hostName;
      publicKey = wg.serverPubKey;
      allowedIPs = [ wg.subnet ];
      endpoint = wg.endpoint;
      persistentKeepalive = 25;
      dynamicEndpointRefreshSeconds = 300;
    }];
  };

  networking = {
    inherit hostName;
    nameservers = [ network.dns.localResolver ];

    interfaces.${network.interface} = { ipv4.addresses = [ network.ip ]; };

    firewall = {
      allowedTCPPorts = allTcpPorts;
      allowedUDPPorts = allUdpPorts;
    };
  };

  system.build.sdImage = pkgs.callPackage "${inputs.nixpkgs}/nixos/lib/make-disk-image.nix" {
    name = "OPi3B-${hostName}-sd-image";
    inherit config lib;
    format = "raw";
    diskSize = "auto";
    copyChannel = false;
    compressImage = true;
  };
}
