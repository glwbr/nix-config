{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.aria.services.playerctld;
  inherit (lib.aria) mkBoolOpt;
in
{
  options.aria.services.playerctld = {
    enable = mkBoolOpt false "Whether or not to enable playerctld.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.playerctl ];
    services.playerctld = {
      enable = true;
    };
  };
}
