{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkDefault mkEnableOption mkIf;
  inherit (lib.aria) mkBoolOpt;

  cfg = config.aria.programs.editors.vscode;
in
{
  options.aria.programs.editors.vscode = {
    enable = mkEnableOption "vscode";
    declarativeConfig = mkBoolOpt true "Whether to let nix manage user settings";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = true;

      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        bmewburn.vscode-intelephense-client
        dbaeumer.vscode-eslint
        eamodio.gitlens
        esbenp.prettier-vscode
        mkhl.direnv
        ms-azuretools.vscode-docker
        vscodevim.vim
        vue.volar
        yzhang.markdown-all-in-one
      ];

      mutableExtensionsDir = false;

      userSettings = mkIf cfg.declarativeConfig {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[dockerfile]" = {
          "editor.defaultFormatter" = "ms-azuretools.vscode-docker";
        };
        "[json]" = {
          "editor.defaultFormatter" = "vscode.json-language-features";
        };

        "editor.bracketPairColorization.enabled" = true;
        "editor.fontFamily" = mkDefault "JetBrainsMono Nerd Font";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 16;
        "editor.fontWeight" = "300";
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;
        "editor.rulers" = [ 120 ];

        "git.openRepositoryInParentFolders" = "always";

        "keyboard.dispatch" = "keyCode";

        "workbench.fontAliasing" = "antialised";
        "workbench.startupEditor" = "none";
        "workbench.tree.indent" = 4;
        "workbench.iconTheme" = "vscode-icons";

        # Misc
        "typescript.updateImportsOnFileMove.enabled" = "always";
        "window.menuBarVisibility" = "toggle";
      };
    };
  };
}
