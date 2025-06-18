{ config, lib, ... }:
let
  cfg = config.aria.programs.terminal;
in
{
  imports = [ ./alacritty ./tmux ];

  options.aria.programs.terminal = {
    enable = lib.mkEnableOption "terminal applications";
  };

  config = lib.mkIf cfg.enable {
    aria.programs.terminal = {
      tmux.enable = lib.mkDefault true;
      alacritty.enable = lib.mkDefault false;
    };
  };
}
