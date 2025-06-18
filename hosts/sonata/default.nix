{ config, inputs, pkgs, hostName, ... }:
{
  imports = [ ./boot.nix ./disko.nix ./hardware.nix inputs.hardware.nixosModules.dell-inspiron-7460 ];

  nvim.enable = true;

  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

  aria = {
    core.users = {
      users.glwbr = {
        name = "glwbr";
        fullName = "Glauber Santana";
        email = "hi@phy0.com";
        extraGroups = [ "wheel" ];
        sshKeys = [ "ssh-ed25521 AAAAC3NzaC1lZDI1NTE5AAAAIOw9mnJmXKHKGvkdlSHJ7dFP2XhlKvQbKogHxwBXFg9o" ];
        extraOptions.packages = with pkgs; [ alacritty kitty firefox spotify telegram-desktop (discord.override { withVencord = true; }) ];
      };
    };

    core.nix.nh.flakePath = "/home/glwbr/projects/personal/nix-config";

    services.openssh = {
      hostAliases.sonata = [ "sonata.phy0.me" ];
      sshAgentAuth = true;
    };

    security = {
      gnupg.enable = true;
      firewall.allowedTCPPorts = [ 51820 8080 ];
    };

    wms.hyprland.enable = true;

    virtualisation = {
      enable = true;
      users = [ "glwbr" ];
      runtime = "docker";
      enableHypervisor = false;
      enableDesktopIntegration = true;
    };

    programs.shell.zoxide.enable = true;
  };

  sops.secrets.wireguard = {
    neededForUsers = true;
  };

  networking = { inherit hostName; };
  networking.wireguard.enable = true;
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.100.0.2/24" ];
      listenPort = 51820;
      privateKeyFile = config.sops.secrets.wireguard.path;
      mtu = 1260;
      peers = [
        {
          publicKey = "3/mf/2/SfUI0vDeZ4fEj36W2srxbLAahNv8epigtPBY=";
          allowedIPs = [ "10.100.0.0/24" ];
          # Or forward only particular subnets
          # allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];
          # Set this to the server IP and port.
          endpoint = "172.233.19.9:51820";
          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };

  system.stateVersion = "24.05";
}
