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
    ../shared/core/system/nix
  ];
  boot = {
    kernelPackages = crossPkgs.linuxPackages_latest;

    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };

    consoleLogLevel = 7;
  };

  hardware.deviceTree.name = "rockchip/rk3566-orangepi-3b-v1.1.dtb";

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
    options = [ "noatime" ];
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
