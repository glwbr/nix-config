{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      bmewburn.vscode-intelephense-client
      dbaeumer.vscode-eslint
      eamodio.gitlens
      ms-azuretools.vscode-docker
      shd101wyy.markdown-preview-enhanced
      vscodevim.vim
      vue.volar
    ];

    mutableExtensionsDir = false;

    userSettings = {
      "keyboard.dispatch" = "keyCode";
      "git.openRepositoryInParentFolders" = "always";
      "editor.minimap.enabled" = false;
    };
  };
}
