{ config, lib, pkgs, ... }:

let
  cfg = config.aria.programs.zathura;
  baserc = builtins.readFile ./zathurarc;
  theme = if cfg.enable then builtins.readFile ./themes/${cfg.theme} else "";
  finalrc = builtins.replaceStrings [ "# THEME_HERE" ] [ theme ] baserc;
in
{
  options.aria.programs.zathura = {
    enable = lib.mkEnableOption "Zathura PDF viewer";

    theme = lib.aria.mkOpt lib.types.str "rose-pine" "Zathura theme to inline into the configuration.";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ zathura ];
    environment.etc."zathurarc".text = finalrc;
  };
}
