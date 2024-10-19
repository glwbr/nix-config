{ config, lib, ... }:
let
  cfg = config.aria.terminal.foot;
  isHyprland = config.aria.wms.hyprland.enable;

  inherit (lib) mkForce mkIf;
  inherit (lib.aria) mkBoolOpt;

in
{
  options.aria.terminal.foot = {
    enable = mkBoolOpt false "Whether or not to enable foot terminal.";
  };

  config = mkIf (cfg.enable && isHyprland) {
    programs.foot = {
      enable = true;
      server.enable = true;

      settings = {
        main = {
          dpi-aware = "no";
          font = mkForce "JetBrainsMono Nerd Font Mono:style=Light:size=32";
          font-size-adjustment = 1;
          pad = "1x1 center";
          term = "xterm-256color";
        };

        mouse.hide-when-typing = "yes";

        scrollback = {
          lines = 10000;
          multiplier = 5;
          indicator-position = "none";
        };

        url = {
          launch = "xdg-open \${url}";
          label-letters = "sadfjklewcmpgh";
          osc8-underline = "url-mode";
          protocols = "http, https, ftp, ftps, file";
          uri-characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+=\"'()[]";
        };

        cursor = {
          color = "191724 e0def4";
          style = "block";
          beam-thickness = 1;
        };
      };
    };
  };
}
