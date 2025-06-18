{ config, lib, ... }:
let
  cfg = config.aria.programs.shell.aliases;
  aliases = import ./aliases.nix;
in
{
  options.aria.programs.shell.aliases = {
    enable = lib.mkEnableOption "common shell aliases";

    sets = {
      utility = lib.aria.mkBoolOpt true "Utility aliases (ls, grep, etc.)";
      system = lib.aria.mkBoolOpt true "System management aliases";
      git = lib.aria.mkBoolOpt true "Git-related aliases";
      nix = lib.aria.mkBoolOpt true "Nix-related aliases";
      development = lib.aria.mkBoolOpt false "Development-related aliases";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.shellAliases =
      lib.optionalAttrs cfg.sets.utility aliases.utility //
      lib.optionalAttrs cfg.sets.system aliases.system //
      lib.optionalAttrs cfg.sets.git aliases.git //
      lib.optionalAttrs cfg.sets.nix aliases.nix //
      lib.optionalAttrs cfg.sets.development (aliases.development or {});
  };
}
