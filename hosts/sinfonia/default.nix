{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  crossPkgs = pkgs.pkgsCross.aarch64-multiplatform;
in
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ../shared/core
  ];

  hardware.deviceTree.name = "rockchip/rk3566-orangepi-3b-v1.1.dtb";

  # Options to move to minimal config
  environment.defaultPackages = [ ];
  documentation.enable = false;

  zramSwap = {
    enable = true;
    swapDevices = 1;
    algorithm = "zstd";
  };

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
    security.sops.enable = true;
    system.nix.nh.enable = true;
    system.locale.enable = true;
    services = {
      openssh.enable = true;
      dbus.enable = true;
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

  system.stateVersion = "24.11";
}
