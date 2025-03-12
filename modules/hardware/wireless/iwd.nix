{
  config,
  lib,
  ...
}: let
  inherit (lib.aria) mkBoolOpt;

  cfg = config.aria.hardware.wireless.iwd;
in {
  options.aria.hardware.wireless.iwd = {
    enable = mkBoolOpt false "Whether to enable iwd";
  };

  config = lib.mkIf cfg.enable {
    networking.wireless.iwd = {
      enable = true;
      settings = {
        IPv6 = {
          Enable = true;
        };
        Settings = {
          AutoConnect = true;
        };
      };
    };
  };
}
