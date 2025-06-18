{ config, lib, pkgs, inputs, hostName, ... }:
{
  imports = [ ./boot.nix ./hardware.nix ];

  networking = {
    inherit hostName;
    interfaces.end0 = {
      ipv4.addresses = [
        {
          address = "192.168.31.160";
          prefixLength = 24;
        }
      ];
    };
  };

  aria.security.firewall = {
    # Clients and peers can use the same port, see listenport
    allowedUDPPorts = [ 51820 ]; 
  };


  sops.secrets.wireguard = {
    neededForUsers = true;
  };

  networking.wireguard.enable = true;
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.100.0.2/24" ];
      listenPort = 51820; # to match firewall allowedUDPPorts (without this wg uses random port numbers)

      privateKeyFile = config.sops.secrets.wireguard.path;
      mtu = 1260;

      peers = [
        {
          # Public key of the server (not a file path).
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

  aria.users = {
    defaultUserShell = pkgs.zsh;
    users.glwbr = {
      name = "glwbr";
      extraGroups = [ "wheel" ];
      fullName = "Glauber Santana";
      email = "glauber.silva14@gmail.com";
    };
  };

  aria.virtualisation.docker = {
    enable = true;
    users = [ "glwbr" ];
  };

  services.journald.extraConfig = "SystemMaxUse=100M";

  system.build.sdImage = import "${inputs.nixpkgs}/nixos/lib/make-disk-image.nix" {
    name = "OPi3B-sd-image";
    copyChannel = false;
    inherit config lib pkgs;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
