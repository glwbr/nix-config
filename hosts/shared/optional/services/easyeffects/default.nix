{
  config,
  lib,
  ...
}:
let
  cfg = config.aria.services.easyeffects;
  audio = config.aria.hardware.audio;

  inherit (lib.aria) mkBoolOpt;
  inherit (lib) mkIf;
in
{
  options.aria.services.easyeffects = {
    enable = mkBoolOpt false "Whether or not to enable easyeffects service.";
  };

  config = mkIf audio {
    services.easyeffects = {
      enable = true;
      preset = "quiet";
    };

    xdg.configFile."easyeffects/output/quiet.json".source = ./quiet.json;
  };
}
