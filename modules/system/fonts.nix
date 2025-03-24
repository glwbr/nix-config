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
      packages = with pkgs; [
        lexend
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        nerd-fonts.jetbrains-mono
      ];

      enableDefaultPackages = false;

      fontconfig = {
        defaultFonts = {
          monospace = [
            "JetBrainsMono"
            "JetBrainsMono Nerd Font"
            "Noto Color Emoji"
          ];
          sansSerif = [
            "Lexend"
            "Noto Color Emoji"
          ];
          serif = [
            "Noto Serif"
            "Noto Color Emoji"
          ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
    };
  };
}
