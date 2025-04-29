{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.aria.terminal.tools.zathura;
  baserc = builtins.readFile ./zathurarc;
  theme = if cfg.enable then builtins.readFile ./themes/${cfg.theme} else "";
  finalrc = builtins.replaceStrings [ "# THEME_HERE" ] [ theme ] baserc;
in
{
  options.aria.terminal.tools.zathura = {
    enable = mkEnableOption "Enable the Zathura PDF viewer";

    theme = mkOption {
      type = types.str;
      default = "rose-pine";
      description = "Zathura theme to inline into the configuration.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ zathura ];
    environment.etc."zathurarc".text = finalrc;
  };
}
