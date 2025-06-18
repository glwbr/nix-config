{ config, lib, pkgs, inputs, hostName, ... }:
let
  cfg = {
    wg0Port = 51820;
    wgPublicKey = "3/mf/2/SfUI0vDeZ4fEj36W2srxbLAahNv8epigtPBY=";
    defaultUserName = "glwbr";
    wireguardNetwork = "10.100.0.0/24";
    staticIP = {
      address = "192.168.31.160";
      prefixLength = 24;
    };
  };
in
{
  imports = [ ./boot.nix ./hardware.nix ];

  aria.core.users = {
    # defaultUserShell = pkgs.zsh;
    users.${cfg.defaultUserName} = {
      name = cfg.defaultUserName;
      extraGroups = [ "wheel" ];
      useSOPSPassword = true;
      sshKeys = [ "ssh-ed25521 AAAAC3NzaC1lZDI1NTE5AAAAIOw9mnJmXKHKGvkdlSHJ7dFP2XhlKvQbKogHxwBXFg9o" ];
      fullName = "Glauber Santana";
      email = "glauber.silva14@gmail.com";
    };
  };

  aria.virtualisation.docker = {
    enable = true;
    users = [ cfg.defaultUserName ];
  };

  sops.secrets.wireguard = { sopsFile = ./secrets.yaml; neededForUsers = false; };

  networking.interfaces.end0.ipv4.addresses = [{
    inherit (cfg.staticIP) address prefixLength;
  }];

  networking.firewall.allowedUDPPorts = [ cfg.wg0Port ];

  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.100.0.2/24" ];
    privateKeyFile = config.sops.secrets.wireguard.path;
    listenPort = cfg.wg0Port;

    peers = [{
      name = hostName;
      endpoint = "172.233.19.9:${toString cfg.wg0Port}";
      publicKey = cfg.wgPublicKey;

      allowedIPs = [ cfg.wireguardNetwork ];
      persistentKeepalive = 25;
      dynamicEndpointRefreshSeconds = 300;
    }];
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
