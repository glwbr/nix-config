{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.aria.programs.terminal.alacritty;

  inherit (lib.aria) mkBoolOpt;
in {
  options.aria.programs.terminal.alacritty = {
    enable = mkBoolOpt false "Whether to enable alacritty";
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty.enable = true;

    home.file = {
      ".config/alacritty/alacritty.toml".source = ./alacritty.toml;
      ".config/alacritty/themes" = {
        recursive = true;
        source = ./themes;
      };
    };
  };
}
