{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt;
  alias = import ./aliases.nix;
  cfg = config.aria.terminal.tools.git;
in
{
  options.aria.terminal.tools.git = {
    enable = mkBoolOpt false "Whether to enable git";
  };

  config = mkIf cfg.enable {
    environment.etc."ignore" = {
      source = ./ignore;
      mode = "0644";
    };

    environment.systemPackages = with pkgs; [ delta ];

    programs.git = {
      enable = true;
      lfs.enable = true;
      config = {
        inherit alias;

        checkout = {
          defaultRemote = "origin";
        };

        core = {
          editor = "nvim";
          pager = "delta";
          excludesFile = "/etc/ignore";
          whitespace = "trailing-space,space-before-tab,indent-with-non-tab";
        };

        delta = {
          dark = true;
          navigate = true;
          true-color = "always";
        };

        diff = {
          colorMoved = "default";
        };

        init = {
          defaultBranch = "main";
        };

        interactive = {
          diffFilter = "delta --color-only";
        };

        merge = {
          conflictStyle = "zdiff3";
        };

        pull = {
          ff = "only";
          rebase = true;
        };

        push = {
          autoSetupRemote = true;
        };

        rebase = {
          autoStash = true;
        };

        user = {
          name = "Glauber Santana";
          email = "hello@glwbr.me";
        };
      };
    };
  };

}
