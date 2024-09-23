{ config, lib, ... }:
let
  cfg = config.aria.terminal.foot;
in
{
  programs.foot = {
    # FIXME: enable only if wayland is present
    enable = lib.mkIf cfg.enable;
    server.enable = true;

    settings = {
      main = {
        dpi-aware = "no";
        font = lib.mkForce "JetBrainsMono Nerd Font Mono:style=Regular:size=16";
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
}
