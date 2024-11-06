{ lib, ... }:
let
  inherit (lib.aria) enabled;
in
{
  imports = [
    ../default.nix
  ];

  aria.programs = {
    editors = {
      neovim = enabled;
    };
    terminal = {
      tools = {
        # direnv = enabled;
        fastfetch = enabled;
        fzf = enabled;
        git = {
          enable = true;
          userEmail = "glauber.silva14@gmail.com";
        };
        tmux = enabled;
        zoxide = enabled;
      };
      shell = {
        zsh = enabled;
      };
    };
  };
}
