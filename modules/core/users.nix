{ config, lib, pkgs, ... }:
let
  cfg = config.aria.core.users;
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;

  userType = lib.types.submodule ({ name, ... }: {
    options = {
      name = lib.aria.mkOpt lib.types.str name "The username";
      email = lib.aria.mkOpt lib.types.str null "The email of the user";
      isSystemUser = lib.aria.mkBoolOpt false "Whether this is a system user";
      fullName = lib.aria.mkOpt lib.types.str null "The full name of the user";
      useSOPSPassword = lib.aria.mkBoolOpt false "Use SOPS for password management";
      hashedPassword = lib.aria.mkOpt (lib.types.nullOr lib.types.str) null "Hashed Password";
      sshKeys = lib.aria.mkListOpt lib.types.str [] "List of SSH keys for the user";
      extraGroups = lib.aria.mkListOpt lib.types.str [] "Additional groups for the user";
      extraOptions = lib.aria.mkOpt lib.types.attrs {} "Extra options passed to users.users.<name>";
    };
  });
in
{
  options.aria.core.users = {
    enable = lib.mkEnableOption "user management";

    users = lib.aria.mkOpt (lib.types.attrsOf userType) {} "User configurations";
    defaultUserShell = lib.aria.mkOpt lib.types.package pkgs.bash "Default shell for users";
    extraGroups = lib.aria.mkListOpt lib.types.str [] "Additional groups to add to all normal users";
    defaultGroups = lib.aria.mkListOpt lib.types.str [ "audio" "input" "plugdev" "power" "video" ] "Groups to add to all normal users";
  };

  config = lib.mkIf cfg.enable {
    users.mutableUsers = false;

    sops.secrets = lib.mkMerge (lib.mapAttrsToList (name: userCfg:
      lib.mkIf userCfg.useSOPSPassword {
        "${name}-password" = { neededForUsers = true; };
      }) cfg.users);

    users.users = lib.mapAttrs (name: userCfg: {
      inherit name;
      isNormalUser = !userCfg.isSystemUser;
      isSystemUser = userCfg.isSystemUser;
      shell = cfg.defaultUserShell;
      openssh.authorizedKeys.keys = userCfg.sshKeys;
      home = if userCfg.isSystemUser then "/var/lib/${name}" else "/home/${name}";
      extraGroups = ifTheyExist ((if userCfg.isSystemUser then [] else cfg.defaultGroups) ++ cfg.extraGroups ++ userCfg.extraGroups);

      hashedPassword = lib.mkIf (!userCfg.useSOPSPassword) userCfg.hashedPassword;
      hashedPasswordFile = lib.mkIf userCfg.useSOPSPassword config.sops.secrets."${name}-password".path;
    } // userCfg.extraOptions) cfg.users;
  };
}
