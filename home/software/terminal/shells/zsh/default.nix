{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.aria.programs.terminal.shell.zsh;
  plugins = import ./plugins pkgs;

  inherit (config.home) homeDirectory;
  inherit (lib.aria) mkBoolOpt;
  inherit (lib) strings;
in
{
  options.aria.programs.terminal.shell.zsh = {
    enable = mkBoolOpt false "Whether to manage zsh settings";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;

      autocd = true;
      autosuggestion.enable = true;
      enableCompletion = true;

      dirHashes = {
        dl = "${homeDirectory}/Downloads";
        dev = "${homeDirectory}/projects";
        dots = "${homeDirectory}/projects/nix-config";
      };

      dotDir = ".config/zsh";

      history = {
        expireDuplicatesFirst = true;
        extended = true;
        ignoreDups = true;
        ignoreSpace = true;
        path = "${config.xdg.dataHome}/zsh/zsh_history";
        save = 100000;
        share = true;
        size = 100000;
      };

      initExtra =
        # bash
        ''
          ${strings.fileContents ./config/misc.zsh}
          ${strings.fileContents ./config/comp.zsh}
          ${strings.fileContents ./config/aliases.zsh}

          # Set LS_COLORS by parsing dircolors output
          LS_COLORS="$(${lib.getExe' pkgs.coreutils "dircolors"} --sh)"
          LS_COLORS="''${''${LS_COLORS#*\'}%\'*}"
          export LS_COLORS
        '';

      inherit (plugins) plugins;

      # shellAliases = { };

      syntaxHighlighting = {
        enable = true;
        highlighters = [
          "main"
          "brackets"
          "line"
          "root"
        ];
      };
    };
  };
}
