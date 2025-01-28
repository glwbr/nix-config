{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.aria) mkBoolOpt;
  cfg = config.aria.programs.editors.vscode;
in {
  options.aria.programs.editors.vscode = {
    enable = mkBoolOpt false "Whether to enable Visual Studio Code";
    declarativeConfig = mkBoolOpt true "Whether to let nix manage user settings";
  };

  config = lib.mkIf cfg.enable {
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

      mutableExtensionsDir = true;

      userSettings = lib.mkIf cfg.declarativeConfig {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[dockerfile]" = {
          "editor.defaultFormatter" = "ms-azuretools.vscode-docker";
        };
        "[json]" = {
          "editor.defaultFormatter" = "vscode.json-language-features";
        };

        "editor.bracketPairColorization.enabled" = true;
        "editor.fontFamily" = lib.mkForce "JetBrainsMono Nerd Font";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 16;
        "editor.fontWeight" = "300";
        "editor.formatOnSave" = false;
        "editor.minimap.enabled" = false;
        "editor.rulers" = [120];

        "git.openRepositoryInParentFolders" = "always";
        "gitblame.inlineMessageEnabled" = true;
        "gitblame.inlineMessageFormat" = "\${author.name} • (\${time.ago}) \${commit.summary}";
        "gitblame.currentUserAlias" = "You";

        "keyboard.dispatch" = "keyCode";

        "terminal.integrated.fontFamily" = lib.mkForce "JetBrainsMono Nerd Font";

        "workbench.colorTheme" = lib.mkForce "Kanagawa";
        "workbench.fontAliasing" = "antialised";
        "workbench.startupEditor" = "none";
        "workbench.tree.indent" = 4;

        # Misc
        "typescript.updateImportsOnFileMove.enabled" = "always";
        "window.menuBarVisibility" = "toggle";
      };
    };
  };
}
