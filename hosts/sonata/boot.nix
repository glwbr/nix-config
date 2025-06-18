{ lib, pkgs, ... }:
{
  boot = {
    consoleLogLevel = 0;
    loader = {
      timeout = 0;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
        editor = false;
      };
    };

    plymouth = {
      enable = true;
      theme = lib.mkForce "deus_ex";
      themePackages = with pkgs; [ (adi1090x-plymouth-themes.override { selected_themes = [ "deus_ex" ]; }) ];
    };

    tmp = {
      useTmpfs = true;
      cleanOnBoot = true;
      tmpfsSize = "50%";
    };

    binfmt.emulatedSystems = [ "aarch64-linux" ];
    initrd.verbose = false;
    initrd.systemd.enable = true;

    kernelParams = [
      "quiet"
      "loglevel=3"
      "rd.systemd.show_status=auto"
      "rd.udev.log_level=3"
      "systemd.show_status=auto"
      "udev.log_level=3"
      "vt.global_cursor_default=0"
    ];
  };

  environment.systemPackages = with pkgs; [ efibootmgr efitools ];
}
