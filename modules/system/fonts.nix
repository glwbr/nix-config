{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.aria) mkBoolOpt;
  cfg = config.aria.system.fonts;
in
{
  options.aria.system.fonts = {
    enable = mkBoolOpt false "Whether to enable font settings";
  };

  config = lib.mkIf cfg.enable {
    fonts = {
      enableDefaultPackages = false;
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        noto-fonts-cjk-sans
        nerd-fonts.noto
      ];

      fontconfig = {
        enable = true;
        subpixel = {
          lcdfilter = "none";
        };
      };
    };
  };
}
