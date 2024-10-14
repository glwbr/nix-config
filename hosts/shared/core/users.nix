{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.aria.user;
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;

  inherit (lib) types;
  inherit (lib.aria) mkOpt;
in
{
  options.aria.user = with types; {
    email = mkOpt str "hello@glwbr.me" "The email of the user.";
    extraGroups = mkOpt (listOf str) [ ] "Groups for the user to be assigned.";
    extraOptions = mkOpt attrs { } "Extra options passed to users.users.<name>.option.";
    fullName = mkOpt str "Glauber Santana" "The full name of the user.";
    name = mkOpt str "glwbr" "The name to use for the user account.";
  };

  config = {
    environment.pathsToLink = [ "/share/zsh" ];
    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      histFile = "$XDG_CACHE_HOME/zsh.history";
    };

    sops.secrets."${cfg.name}" = {
      sopsFile = ../secrets.yaml;
      neededForUsers = true;
    };

    users.mutableUsers = false;
    users.users.${cfg.name} = {
      inherit (cfg) name;
      extraGroups = [
        "wheel"
        #"systemd-journal"
        # "mpd"
        "audio"
        "video"
        #"input"
        "power"
        # "nix"
      ] ++ ifTheyExist cfg.extraGroups;

      hashedPasswordFile = config.sops.secrets."${cfg.name}".path;
      home = "/home/${cfg.name}";
      isNormalUser = true;
      shell = pkgs.zsh;
      uid = 1000;
    } // cfg.extraOptions;
  };
}
