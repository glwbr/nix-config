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
        ny
        sf-pro
        sf-mono
        noto-fonts
        sf-mono-liga
        noto-fonts-emoji
        noto-fonts-cjk-sans
        nerd-fonts.jetbrains-mono
      ];

      enableDefaultPackages = false;

      fontconfig = {
        defaultFonts = {
          monospace = [
            "SF Mono"
            "Liga SFMono Nerd Font"
            "Noto Color Emoji"
          ];
          sansSerif = [
            "SF Pro"
            "Noto Color Emoji"
          ];
          serif = [
            "New York"
            "Noto Serif"
            "Noto Color Emoji"
          ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
    };
  };
}
