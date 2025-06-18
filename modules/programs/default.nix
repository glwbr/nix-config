{ config, lib, ... }:
let
  cfg = config.aria.programs;
in
{
  imports = [ ./git ./obs ./shell ./terminal ./zathura ];

  options.aria.programs.enable = lib.mkEnableOption "aria program suite";

  config = lib.mkIf cfg.enable {
    aria.programs = {
      git.enable = lib.mkDefault true;
      shell.enable = lib.mkDefault true;
      terminal.enable = lib.mkDefault true;

      obs.enable = lib.mkDefault false;
      zathura.enable = lib.mkDefault false;
    };
  };
}
