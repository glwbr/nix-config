{ lib, config, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd = {
      supportedFilesystems = [ "nfs" ];
      kernelModules = [ "kvm-intel" "nfs" ];
      availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" ];
    };
  };

  services.fwupd.enable = true;
  services.fwupd.daemonSettings.EspLocation = config.boot.loader.efi.efiSysMountPoint;

  networking.useDHCP = lib.mkDefault true;
  powerManagement.cpuFreqGovernor = "schedutil";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
