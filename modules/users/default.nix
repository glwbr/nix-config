{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) types;
  inherit (lib.aria) mkBoolOpt mkOpt;
  cfg = config.aria.users;
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;

  userType = types.submodule {
    options = with types; {
      name = mkOpt str null "The username";
      email = mkOpt str null "The email of the user";
      fullName = mkOpt str null "The full name of the user";
      hashedPassword = mkOpt str null "The hashed password for the user";
      extraGroups = mkOpt (listOf str) [ ] "Additional groups for the user";
      extraOptions = mkOpt attrs { } "Extra options passed to users.users.<name>";
      sshKeys = mkOpt (listOf str) [ ] "List of SSH keys for the user";
    };
  };
in
{
  options.aria.users = with types; {
    enable = mkBoolOpt false "Whether to enable user management";
    users = mkOpt (attrsOf userType) { } "User configurations";
    defaultUserShell = mkOpt package pkgs.zsh "Default shell for users";

    defaultGroups = mkOpt (listOf str) [
      "audio"
      "input"
      "plugdev"
      "power"
      "video"
      "wheel"
    ] "Groups to add to all normal users";

    extraGroups = mkOpt (listOf str) [ ] "Additional groups to add to all normal users";

    root = {
      enable = mkBoolOpt false "Whether to configure root user";
      hashedPassword = mkOpt str null "Root's hashed password";
      extraGroups = mkOpt (listOf str) [ ] "Additional groups for root";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      users.mutableUsers = false;

      users.users = lib.mapAttrs (
        name: userCfg:
        {
          inherit (userCfg) name hashedPassword;
          isNormalUser = true;
          home = "/home/${name}";
          shell = cfg.defaultUserShell;
          extraGroups = ifTheyExist (cfg.defaultGroups ++ cfg.extraGroups ++ userCfg.extraGroups);
          openssh.authorizedKeys.keys = userCfg.sshKeys;
        }
        // userCfg.extraOptions
      ) cfg.users;
    })
  ];
}
