{
  config,
  lib,
  ...
}:
let
  inherit (lib.aria) mkBoolOpt;
  cfg = config.aria.services.gpg;
in
{
  options.aria.services.gpg = {
    enable = mkBoolOpt false "Whether to enable gpg";
  };

  config = lib.mkIf cfg.enable {
    programs.gnupg = {
      agent = {
        enable = cfg.enable;
        enableSSHSupport = true;
      };
    };
  };
}
