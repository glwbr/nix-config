{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt;

  cfg = config.aria.programs.terminal.tools.tmux;
  plugins = with pkgs.tmuxPlugins; [
    { plugin = better-mouse-mode; }
    { plugin = vim-tmux-navigator; }
    {
      plugin = resurrect;
      extraConfig =
        # tmux
        ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurect-capture-pane-contents 'on'
          set -g @resurect-processes 'ssh btm yazi'
          set -g @resurect-dir '~/.local/state/tmux/resurrect'
        '';
    }
    {
      plugin = continuum;
      extraConfig =
        # tmux
        ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60'
        '';
    }
  ];
in {
  options.aria.programs.terminal.tools.tmux = {
    enable = mkBoolOpt false "Whether or not to enable tmux.";
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      clock24 = true;
      disableConfirmationPrompt = true;
      escapeTime = 0;
      focusEvents = true;
      keyMode = "vi";
      historyLimit = 100000;
      mouse = true;
      newSession = true;
      prefix = "C-a";
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "alacritty";
      inherit plugins;
      extraConfig = builtins.readFile ./tmux.conf;
    };
  };
}
