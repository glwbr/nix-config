{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt;

  cfg = config.aria.system.xkb;
in
{
  options.aria.system.xkb = {
    enable = mkBoolOpt false "Whether to configure xkb.";
  };

  config = mkIf cfg.enable {
    console.useXkbConfig = true;

    services.xserver = {
      xkb = {
        layout = "us";
        options = "caps:swapescape";
      };
    };
  };
}
