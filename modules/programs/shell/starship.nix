{ config, lib, ... }:
let
  cfg = config.aria.programs.shell.starship;
in
{
  options.aria.programs.shell.starship.enable = lib.mkEnableOption "starship prompt";

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      interactiveOnly = false;
      settings = {
        format = lib.concatStrings [
          "$directory"
          "$git_branch"
          "$git_status"
          "$character"
        ];

        # Rose Pine main palette
        palette = "rose_pine";

        palettes.rose_pine = {
          base = "#191724";
          surface = "#1f1d2e";
          overlay = "#26233a";
          muted = "#6e6a86";
          subtle = "#908caa";
          text = "#e0def4";
          love = "#eb6f92";
          gold = "#f6c177";
          rose = "#ebbcba";
          pine = "#31748f";
          foam = "#9ccfd8";
          iris = "#c4a7e7";
        };

        character = {
          success_symbol = "[➜](bold foam)";
          error_symbol = "[➜](bold love)";
        };

        directory = {
          style = "bold pine";
          truncation_length = 3;
          truncate_to_repo = false;
        };

        git_branch = {
          symbol = " ";
          style = "bold iris";
          format = "[$symbol$branch]($style) ";
        };

        git_status = {
          style = "bold gold";
          format = "[$all_status$ahead_behind]($style)";
          conflicted = "=";
          ahead = "⇡";
          behind = "⇣";
          diverged = "⇕";
          up_to_date = "";
          untracked = "?";
          stashed = "$";
          modified = "!";
          staged = "+";
          renamed = "»";
          deleted = "✘";
        };
      };
    };
  };
}
