{
  config,
  lib,
  ...
}:
let
  cfg = config.aria.security.pam;

  inherit (lib.aria) mkBoolOpt;
in
{
  options.aria.security.pam = {
    enable = mkBoolOpt false "Whether or not to enable pam.";
  };

  config = lib.mkIf cfg.enable {
    security.pam = {
      loginLimits = [
        {
          domain = "*";
          item = "nofile";
          type = "-";
          value = "65536";
        }
      ];

      # TODO: handle this inside hyprlock or swaylock config
      services.hyprlock.text = "auth include login";
    };
  };
}
