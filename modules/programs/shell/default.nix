{ config, lib, pkgs, ... }:
let
  cfg = config.aria.programs.shell;
  corePackages = with pkgs; [ fd ripgrep sd eza ];
  extraPackages = with pkgs; [ bat bottom dua duf procs skim tealdeer yt-dlp ];
in
{
  imports = [ ./bash.nix ./zoxide.nix ./direnv.nix ./starship.nix ./zsh.nix ./aliases ];

  options.aria.programs.shell = {
    enable = lib.mkEnableOption "opinionated shell configs";

    includeExtras = lib.aria.mkBoolOpt false "Extra 'nice-to-have' tools";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = corePackages ++ lib.optionals cfg.includeExtras extraPackages;

    aria.programs.shell = {
      zsh.enable = lib.mkDefault true;
      bash.enable = lib.mkDefault true;
      zoxide.enable = lib.mkDefault true;
      aliases.enable = lib.mkDefault true;

      direnv.enable = lib.mkDefault false;
      starship.enable = lib.mkDefault false;
    };
  };
}
