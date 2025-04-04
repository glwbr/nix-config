{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt;
  cfg = config.aria.terminal.tools.alacritty;
in
{
  options.aria.terminal.tools.alacritty = {
    enable = mkBoolOpt false "Whether to enable alacritty";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ alacritty ];
  };
}
