{
  config,
  lib,
  ...
}: let
  inherit (lib.aria) mkBoolOpt;

  cfg = config.aria.security.doas;
  doasUsers = lib.filterAttrs (name: user: user.extraGroups != [] && builtins.elem "wheel" user.extraGroups) config.aria.users.users;
  doasUserNames = builtins.attrNames doasUsers;
in {
  options.aria.security.doas = {
    enable = mkBoolOpt false "Whether to enable doas";
    noPass = mkBoolOpt false "Whether disable password need";
  };

  config = lib.mkIf cfg.enable {
    environment.shellAliases.sudo = "doas";

    security = {
      sudo.enable = false;
      doas = {
        enable = true;
        extraRules = [
          {
            keepEnv = true;
            noPass = cfg.noPass;
            users = doasUserNames;
          }
        ];
      };
    };
  };
}
