{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      bmewburn.vscode-intelephense-client
      dbaeumer.vscode-eslint
      eamodio.gitlens
      ms-azuretools.vscode-docker
      vscodevim.vim
      vue.volar
      yzhang.markdown-all-in-one
    ];

    mutableExtensionsDir = false;

    userSettings = {
      "keyboard.dispatch" = "keyCode";
    };
  };
}
