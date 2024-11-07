{
  config,
  lib,
  ...
}:
let
  cfg = config.aria.dms.greetd;

  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt;
in
{
  options.aria.dms.greetd = {
    enable = mkBoolOpt false "Whether or not to enable greetd.";
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = rec {
        default_session = {
          command = "Hyprland &> /dev/null";
          user = config.aria.user.name;
        };
        initial_session = default_session;
      };
    };
  };
}
