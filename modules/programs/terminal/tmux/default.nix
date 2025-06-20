{ config, lib, pkgs, ... }:
let
  cfg = config.aria.programs.terminal.tmux;
in
{
  options.aria.programs.terminal.tmux.enable = lib.mkEnableOption "tmux";

  config = lib.mkIf cfg.enable {
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
      plugins = with pkgs.tmuxPlugins; [ better-mouse-mode vim-tmux-navigator resurrect continuum ];
      extraConfigBeforePlugins = ''
        # Configuration for resurrect plugin
        set -g @resurrect-strategy-nvim 'session'
        set -g @resurrect-capture-pane-contents 'on'
        set -g @resurrect-processes 'ssh btm yazi'
        set -g @resurrect-dir '~/.local/state/tmux/resurrect'

        # Configuration for continuum plugin
        set -g @continuum-restore 'on'
        set -g @continuum-save-interval '30'
      '';
      extraConfig = builtins.readFile ./tmux.conf;
    };
  };
}
