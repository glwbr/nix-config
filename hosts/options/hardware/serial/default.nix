{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.aria.hardware.serial;

  inherit (lib.aria) mkBoolOpt;
in
{
  options.aria.hardware.serial = {
    # TODO: find a better place for this, maybe include it with adb-tools.
    enable = mkBoolOpt false "Whether or not to enable serial tools.";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.picocom ];

    aria.user.extraGroups = [ "dialout" ];
  };
}
