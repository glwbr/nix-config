{ config, lib, ... }:
let
  cfg = config.aria.system.wireless.iwd;
  inherit (lib.aria) mkBoolOpt;
in
{
  options.aria.system.wireless.iwd = {
    enable = mkBoolOpt false "Whether or not to enable wireless support through iwd.";
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
