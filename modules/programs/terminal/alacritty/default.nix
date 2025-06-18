{ config, lib, pkgs, ... }:
let
  cfg = config.aria.programs.terminal.alacritty;
in
{
  options.aria.programs.terminal.alacritty.enable = lib.mkEnableOption "alacritty";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ alacritty ];
  };
}
