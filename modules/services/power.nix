{
  config,
  lib,
  ...
}:
let
  inherit (lib.aria) mkBoolOpt;
  cfg = config.aria.services.power;
in
{
  options.aria.services.power = {
    enable = mkBoolOpt false "Whether to enable power management";
  };

  config = lib.mkIf cfg.enable {
    powerManagement.powertop.enable = true;
    services = {
      logind = {
        lidSwitch = "suspend";
        lidSwitchExternalPower = "lock";
      };
      tlp.enable = true;
      upower.enable = true;
    };
  };
}
