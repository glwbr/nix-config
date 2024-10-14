{
  config,
  lib,
  ...
}:
let
  inherit (lib.aria) mkBoolOpt;

  cfg = config.aria.security.doas;
in
{
  options.aria.security.doas = {
    enable = mkBoolOpt false "Whether or not to replace sudo with doas.";
  };

  config = lib.mkIf cfg.enable {
    # Add an alias to the shell for backward-compat and convenience.
    environment.shellAliases = {
      sudo = "doas";
    };

    # Disable sudo
    security.sudo.enable = false;

    # Enable and configure `doas`.
    security.doas = {
      enable = true;
      extraRules = [
        {
          keepEnv = true;
          noPass = true;
          users = [ config.aria.user.name ];
        }
      ];
    };
  };
}
