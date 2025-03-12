{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt;
  cfg = config.aria.tools.tmux;
in
{
  options.aria.tools.tmux = {
    enable = mkBoolOpt false "Whether to enable tmux";
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      clock24 = true;
      escapeTime = 0;
      keyMode = "vi";
      historyLimit = 100000;
      newSession = true;
      shortcut = "a";
      terminal = "alacritty";
      plugins = with pkgs.tmuxPlugins; [
        better-mouse-mode
        vim-tmux-navigator
        resurrect
        continuum
      ];
      extraConfig = builtins.readFile ./tmux.conf;
    };
  };
}
