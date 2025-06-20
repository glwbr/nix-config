{ config, inputs, pkgs, hostName, ... }:
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
  imports = [ ./boot.nix ./disko.nix ./hardware.nix inputs.hardware.nixosModules.dell-inspiron-7460 ];

  nvim.enable = true;

  environment.sessionVariables.EDITOR = "nvim";
  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

  aria = {
    core.users = {
      users.${username} = {
        name = username;
        email = "hi@phy0.com";
        useSOPSPassword = true;
        fullName = "Glauber Santana";
        extraGroups = [ "wheel" "network" ];
        sshKeys = [ "ssh-ed25521 AAAAC3NzaC1lZDI1NTE5AAAAIOw9mnJmXKHKGvkdlSHJ7dFP2XhlKvQbKogHxwBXFg9o" ];
        extraOptions.packages = with pkgs; [ alacritty kitty firefox spotify telegram-desktop (discord.override { withVencord = true; }) ];
      };
    };

    core.nix.nh.flakePath = "/home/glwbr/projects/personal/nix-config";

    programs.shell.zoxide.enable = true;

    security.gnupg.enable = true;

    virtualisation = {
      enable = true;
      users = [ username ];
      runtime = "docker";
      enableHypervisor = false;
      enableDesktopIntegration = true;
    };

    desktop.hyprland.enable = true;
  };

  sops.secrets.wireguard = { neededForUsers = false; sopsFile = ./secrets.yaml; };

  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.5.5.3/32" ];
    privateKeyFile = config.sops.secrets.wireguard.path;
    #INFO: without this wg uses random port
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
}
