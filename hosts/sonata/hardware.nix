{ lib, config, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" ];
      supportedFilesystems = [ "nfs" ];
      kernelModules = [ "kvm-intel" "nfs" ];
    };
  };

  services.fwupd.enable = true;
  services.fwupd.daemonSettings.EspLocation = config.boot.loader.efi.efiSysMountPoint;

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  powerManagement.cpuFreqGovernor = "schedutil";
}
