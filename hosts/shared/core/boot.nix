_: {
  boot = {
    bootspec.enable = true;
    initrd = {
      systemd.enable = true;
      supportedFilesystems = [ "ntfs" ];
    };

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    tmp.cleanOnBoot = true;
  };
}
