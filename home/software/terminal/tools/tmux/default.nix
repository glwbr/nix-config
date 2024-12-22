{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
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
      plugin = vim-tmux-navigator;
    }
    {
      plugin = rose-pine;
      extraConfig =
        # tmux
        ''
          set -g @rose_pine_variant 'main'
          set -g @rose_pine_host 'on'
          set -g @rose_pine_date_time ""
          set -g @rose_pine_user 'on'
          set -g @rose_pine_left_separator '  '
          set -g @rose_pine_bar_bg_disable 'on'
        '';
    }
    {
      plugin = resurrect;
      extraConfig =
        # tmux
        ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurect-capture-pane-contents 'on'
          set -g @resurect-processes 'ssh lazygit yazi'
          set -g @resurect-dir '~/.tmux/resurrect'
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
      historyLimit = 100000;
      mouse = true;
      prefix = "C-a";
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "xterm-256color";
      extraConfig =
        # tmux
        ''
          bind -n M-H previous-window
          bind -n M-L next-window
          bind c new-window -c "#{pane_current_path}"
          bind '-' split-window -v -c "#{pane_current_path}"
          bind '|' split-window -h -c "#{pane_current_path}"
          unbind %
          unbind-key '"'
          set -g default-terminal "tmux-256color"
          set -sg escape-time 0
          set -g renumber-windows on
          set -g status-interval 3
          set -g terminal-overrides "alacritty:RGB"
          set -g status-position top
        '';
      inherit plugins;
    };
  };
}
