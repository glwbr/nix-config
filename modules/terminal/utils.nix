{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt;

  cfg = config.aria.terminal.tools.utils;
in
{
  options.aria.terminal.tools.utils = {
    enable = mkBoolOpt true "Wether to enable cli utilities";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fd
      bat
      eza
      skim
      bottom
      ripgrep
    ];
  };
}
