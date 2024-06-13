{lib, ...}: {
  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = lib.mkForce "DejaVu Sans Mono:size=14";
        font-size-adjustment = 1;
        dpi-aware = "no";
        pad = "5x5center";
        notify = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
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
        style = "beam";
        beam-thickness = 1;
      };
    };
  };
}
