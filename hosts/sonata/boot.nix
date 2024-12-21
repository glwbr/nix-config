{config, ...}: {
  boot = {
    initrd = {
      supportedFilesystems = ["nfs"];
      kernelModules = ["nfs"];
    };

    binfmt.emulatedSystems = ["aarch64-linux"];

    kernelModules = ["v4l2loopback"];
    kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];
    extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
  };
}
