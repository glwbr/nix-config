{ lib, ... }:
let
  inherit (lib.aria) enabled;
in
{
  imports = [
    ../default.nix
    ./stylix.nix
    # inputs.nix-index-db.hmModules.nix-index
  ];

  aria = {
    programs = {
      browsers = {
        firefox = {
          enable = true;
          gpuAcceleration = true;
          hardwareDecoding = true;
          settings = {
            "media.av1.enabled" = false;
            "media.hardwaremediakeys.enabled" = true;
          };
        };
        google-chrome = enabled;
      };

      editors = {
        neovim = enabled;
        vscode = enabled;
      };

      terminal = {
        tools = {
          direnv = enabled;
          fastfetch = enabled;
          fzf = enabled;
          git = {
            enable = true;
            userEmail = "glauber.silva14@gmail.com";
          };
          tmux = enabled;
	  yazi = enabled;
          zoxide = enabled;
        };
        shell.zsh = enabled;
      };
      wms.hyprland = enabled;
    };

    services = {
      udiskie = enabled;
      dunst = enabled;
      easyeffects = enabled;
    };
  };
}
