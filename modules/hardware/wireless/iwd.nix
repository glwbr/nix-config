{ config, lib, ... }:
let
  cfg = config.aria.hardware.wireless.iwd;
in
{
  options.aria.hardware.wireless.iwd = {
    enable = lib.mkEnableOption "iwd wireless daemon";
  };

  config = lib.mkIf cfg.enable {
    networking.wireless.iwd = {
      enable = true;
      settings = {
        IPv6.Enable = true;
        Settings.AutoConnect = true;
      };
    };

    # Ensure wpa_supplicant is disabled when using iwd
    networking.wireless.enable = false;
  };
}
