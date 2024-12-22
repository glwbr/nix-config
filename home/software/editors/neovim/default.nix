{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt;

  cfg = config.aria.programs.editors.neovim;
in {
  options.aria.programs.editors.neovim = {
    enable = mkBoolOpt true "Whether to enable neovim.";
    default = mkBoolOpt true "Whether to set neovim as the session EDITOR.";
  };

  config = mkIf cfg.enable {
    home = {
      packages = [pkgs.inputs.corgix.default];
      sessionVariables.EDITOR = "nvim";
      shellAliases.v = "nvim";
    };
  };
}
