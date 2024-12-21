{
  config,
  lib,
  ...
}: let
  inherit (lib.aria) mkBoolOpt;

  cfg = config.aria.security.pam;
in {
  options.aria.security.pam = {
    enable = mkBoolOpt false "Whether to enable pam";
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
