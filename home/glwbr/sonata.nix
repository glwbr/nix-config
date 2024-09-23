_: {
  imports = [
    ../default.nix
    ./stylix.nix
    # inputs.nix-index-db.hmModules.nix-index
  ];

  aria.programs = {
    editors = {
      neovim.enable = true;
    };
    terminal.tools = {
      git = {
        enable = true;
        userEmail = "glauber.silva14@gmail.com";
      };
      tmux.enable = true;
    };
  };
}
