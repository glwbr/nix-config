{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.aria.programs.browsers.google-chrome;

  inherit (lib.aria) mkBoolOpt;
in {
  options.aria.programs.browsers.google-chrome = {
    enable = mkBoolOpt false "Whether or not to enable Google Chrome.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.google-chrome];
  };
}
