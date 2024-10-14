{ config, ... }:
{
  boot = {
    initrd = {
      supportedFilesystems = [ "nfs" ];
      kernelModules = [ "nfs" ];
    };

    kernelModules = [ "v4l2loopback" ];
    kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  };
}
