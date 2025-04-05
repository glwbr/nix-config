{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  inherit (lib.aria) enabled;
in
{
  imports = [
    ./boot.nix
    ./hardware.nix
  ];

  hardware.deviceTree.name = "rockchip/rk3566-orangepi-3b-v1.1.dtb";

  networking = {
    hostName = "sinfonia";
    interfaces.end0 = {
      ipv4.addresses = [
        {
          address = "192.168.31.160";
          prefixLength = 24;
        }
      ];
    };
  };

  aria = {
    profiles.minimal = enabled;
    users = {
      enable = true;
      defaultUserShell = pkgs.zsh;

      users.glwbr = {
        name = "glwbr";
        email = "glauber.silva14@gmail.com";
        fullName = "Glauber Santana";
        hashedPassword = "$y$j9T$gRWruTQzJkmoHO7AaStnb1$1QHo3o.vdl.64VV3ooLsUxs0DHTTMSrCMzY1Kl2FL61";
        extraGroups = [ "wheel" ];
      };
    };
    system = {
      nix.nh = enabled;
    };
  };

  services = {
    journald.extraConfig = "SystemMaxUse=100M";
  };

  system.build = {
    sdImage = import "${inputs.nixpkgs}/nixos/lib/make-disk-image.nix" {
      name = "orangepi3b-sd-image";
      copyChannel = false;
      inherit config lib pkgs;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
