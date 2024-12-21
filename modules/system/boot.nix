{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.aria.system.boot;

  inherit (lib.aria) mkBoolOpt;
in {
  options.aria.system.boot = {
    enable = mkBoolOpt false "Whether to enable extra boot settings";
    plymouth = mkBoolOpt false "Whether to enable plymouth boot splash";
    silentBoot = mkBoolOpt false "Whether to enable silent boot";
    secureBoot = mkBoolOpt false "Whether to enable secure boot";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      efibootmgr
      efitools
    ];

    boot = {
      consoleLogLevel =
        if cfg.silentBoot
        then 0
        else 3;

      initrd.systemd.enable = true;
      initrd.verbose = !cfg.silentBoot;

      kernelParams =
        lib.optionals cfg.plymouth ["quiet"]
        ++ lib.optionals cfg.silentBoot [
          "quiet"
          "loglevel=3"
          "rd.systemd.show_status=auto"
          "rd.udev.log_level=3"
          "systemd.show_status=auto"
          "udev.log_level=3"
          "vt.global_cursor_default=0"
        ];

      loader = {
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot";
        };

        systemd-boot = {
          enable = !cfg.secureBoot;
          configurationLimit = 20;
          editor = false;
        };

        timeout = 0;
      };

      plymouth = {
        enable = cfg.plymouth;
        theme = lib.mkForce "rings";
        themePackages = with pkgs; [
          (adi1090x-plymouth-themes.override {
            selected_themes = ["rings"];
          })
        ];
      };

      tmp = {
        useTmpfs = true;
        cleanOnBoot = true;
        tmpfsSize = "50%";
      };
    };

    services.fwupd = {
      enable = true;
      daemonSettings.EspLocation = config.boot.loader.efi.efiSysMountPoint;
    };
  };
}
