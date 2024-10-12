{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.aria.dms.greetd;
in
{
  options.aria.dms.greetd = {
    enable = mkEnableOption "greetd";
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = rec {
        default_session = {
          command = "Hyprland &> /dev/null";
          user = "glwbr";
        };
        initial_session = default_session;
      };
    };
  };
}
