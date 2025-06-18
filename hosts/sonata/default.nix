{ config, inputs, pkgs, hostName, ... }:
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
  imports = [ ./boot.nix ./disko.nix ./hardware.nix inputs.hardware.nixosModules.dell-inspiron-7460 ];

  nvim.enable = true;

  environment.sessionVariables.EDITOR = "nvim";
  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

  aria = {
    core.users = {
      users.glwbr = {
        name = "glwbr";
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
      users = [ "glwbr" ];
      runtime = "docker";
      enableHypervisor = false;
      enableDesktopIntegration = true;
    };

    desktop.hyprland.enable = true;
  };

  sops.secrets.wireguard = { neededForUsers = false; sopsFile = ./secrets.yaml; };

  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.100.0.3/24" ];
    privateKeyFile = config.sops.secrets.wireguard.path;
    listenPort = cfg.wg0Port;

    peers = [{
      name = hostName;
      publicKey = cfg.wgPublicKey;
      endpoint = "172.233.19.9:${toString cfg.wg0Port}";

      allowedIPs = [ "10.100.0.0/24" ];
      persistentKeepalive = 25;
      dynamicEndpointRefreshSeconds = 300;
    }];
  };
}
