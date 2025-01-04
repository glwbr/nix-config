{
  config,
  lib,
  ...
}: let
  cfg = config.aria.services.easyeffects;
  #TODO: find a way to access this: audio = osConfig.aria.hardware.audio;

  inherit (lib.aria) mkBoolOpt;
in {
  options.aria.services.easyeffects = {
    enable = mkBoolOpt false "Whether to manage easyeffects settings";
  };

  config = lib.mkIf cfg.enable {
    services.easyeffects = {
      enable = true;
      # preset = "quiet";
    };

    home.file.".config/easyeffects/autoload" = {
      recursive = true;
      source = ./autoload;
    };

    home.file.".config/easyeffects/input" = {
      recursive = true;
      source = ./input;
    };

    home.file.".config/easyeffects/output" = {
      recursive = true;
      source = ./output;
    };

    home.file.".config/easyeffects/irs" = {
      recursive = true;
      source = ./irs;
    };
  };
}
