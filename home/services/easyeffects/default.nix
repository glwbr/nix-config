{
  config,
  lib,
  ...
}:
let
  cfg = config.aria.services.easyeffects;
  #TODO: find a way to access this: audio = osConfig.aria.hardware.audio;

  inherit (lib.aria) mkBoolOpt;
in
{
  options.aria.services.easyeffects = {
    enable = mkBoolOpt false "Whether or not to manage easyeffects settings.";
  };

  config = lib.mkIf cfg.enable {
    services.easyeffects = {
      enable = true;
      preset = "quiet";
    };

    xdg.configFile."easyeffects/output/quiet.json".source = ./quiet.json;
  };
}
