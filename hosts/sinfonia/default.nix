{ config, lib, pkgs, inputs, hostName, ... }:
let
  username = "glwbr";
  wg = {
    port = 51820;
    subnet = "10.5.5.0/24";
    endpoint = "vpn.phy0.me:${toString wg.port}";
    serverPubKey = "/ko07sTopPxjUJijyKz4dbd5lXGX0qSpQkrvyJB9+QM=";
  };
in
{
  imports = [ ./boot.nix ./hardware.nix ];

  aria.core.users = {
    defaultUserShell = pkgs.zsh;
    users.${username} = {
      name = username;
      extraGroups = [ "wheel" ];
      useSOPSPassword = true;
      sshKeys = [ "ssh-ed25521 AAAAC3NzaC1lZDI1NTE5AAAAIOw9mnJmXKHKGvkdlSHJ7dFP2XhlKvQbKogHxwBXFg9o" ];
      fullName = "Glauber Santana";
      email = "glauber.silva14@gmail.com";
    };
  };

  aria.virtualisation.docker = {
    enable = true;
    users = [ username ];
  };

  sops.secrets.wireguard = { sopsFile = ./secrets.yaml; neededForUsers = false; };

  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.5.5.2/32" ];
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

  networking.firewall.allowedTCPPorts = [ 8096 ];
  networking.firewall.allowedUDPPorts = [ wg.port ];
  networking.interfaces.end0.ipv4.addresses = [{ address = "192.168.31.160"; prefixLength = 24; }];

  system.build.sdImage = pkgs.callPackage "${inputs.nixpkgs}/nixos/lib/make-disk-image.nix" {
    name = "OPi3B-${hostName}-sd-image";
    inherit config lib;
    format = "raw";
    diskSize = "auto";
    copyChannel = false;
    compressImage = true;
  };
}
