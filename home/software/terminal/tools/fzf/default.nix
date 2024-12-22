{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.aria.programs.terminal.tools.fzf;
  hasZsh = config.aria.programs.terminal.shell.zsh.enable;

  inherit (lib) getExe mkIf;
  inherit (lib.aria) mkBoolOpt;
in {
  options.aria.programs.terminal.tools.fzf = {
    enable = mkBoolOpt true "Whether or not to enable fzf.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fd
      ripgrep
    ];

    programs.fzf = {
      enable = true;

      defaultCommand = "${getExe pkgs.ripgrep} --files --hidden --iglob '!.git/**'";

      defaultOptions = [
        "--layout=reverse"
        "--exact"
        "--bind=alt-p:toggle-preview,alt-a:select-all"
        "--multi"
        "--no-mouse"
        "--info=inline"

        "--ansi"
        "--with-nth=1.."
        "--pointer=' '"
        "--pointer=' '"
        "--header-first"
        "--border=rounded"
      ];

      enableBashIntegration = true;
      enableZshIntegration = hasZsh;
      tmux.enableShellIntegration = true;
    };
  };
}
