{ lib, pkgs, ... }:
{
  boot = {
    initrd = {
      supportedFilesystems = [ "ntfs" ];
      kernelModules = [ "phy_rockchip_naneng_combphy" ];
      systemd = {
        enable = true;
        emergencyAccess = true;
      };
    };

    kernelPackages = pkgs.linuxPackages_latest;

    tmp = {
      useTmpfs = true;
      tmpfsSize = "100%";
    };

    loader = lib.mkDefault {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
      timeout = 5;
    };

    consoleLogLevel = lib.mkDefault 7;
  };
}
