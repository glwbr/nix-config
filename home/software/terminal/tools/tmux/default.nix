{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.aria) mkBoolOpt;

  cfg = config.aria.programs.terminal.tools.tmux;
  plugins = with pkgs.tmuxPlugins; [
    {
      plugin = better-mouse-mode;
      extraConfig =
        # tmux
        ''
          set-option -g mouse on
        '';
    }
    {
      plugin = gruvbox;
      extraConfig =
        # tmux
        ''
          set -g @tmux-gruvbox 'dark'
        '';
    }
    {
      plugin = continuum;
      extraConfig =
        # tmux
        ''
          set -g @continuum-restore 'on'
        '';
    }
    {
      plugin = resurrect;
      extraConfig =
        # tmux
        ''
          set -g @resurect-strategy-vim 'session'
          set -g @resurect-strategy-nvim 'session'
          set -g @resurect-capture-pane-contents' 'on'
          set -g @resurect-processes 'ssh lazygit yazi'
          set -g @resurect-dir '~/.tmux/resurrect'
        '';
    }
  ];
in
{
  options.aria.programs.terminal.tools.tmux = {
    enable = mkEnableOption "tmux";
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      clock24 = true;
      historyLimit = 100000;
      mouse = true;
      newSession = true;
      prefix = "C-a";
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "tmux-256color";

      inherit plugins;
    };
  };
}
