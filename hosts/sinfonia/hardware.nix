{ lib, pkgs, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  hardware = {
    enableRedistributableFirmware = true;
    deviceTree.name = "rockchip/rk3566-orangepi-3b-v1.1.dtb";
  };

  powerManagement.cpuFreqGovernor = "schedutil";

  boot = {
    loader.grub.enable = false;
    loader.generic-extlinux-compatible.enable = true;

    initrd = {
      supportedFilesystems = [ "ntfs" ];
      availableKernelModules = [ "nvme" ];
      kernelModules = [ "phy_rockchip_naneng_combphy" ];
      systemd = { enable = true; emergencyAccess = true; };
    };

    kernelModules = [ ];
    extraModulePackages = [ ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "cma=128M" ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.end0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
