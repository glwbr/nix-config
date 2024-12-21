{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt;

  cfg = config.aria.security.keyring;
in {
  options.aria.security.keyring = {
    enable = mkBoolOpt false "Whether to enable gnome keyring";
  };

  config = mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = true;
  };
}
