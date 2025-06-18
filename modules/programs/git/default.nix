{ config, lib, pkgs, ... }:
let
  alias = import ./aliases.nix;
  cfg = config.aria.programs.git;
in
{
  options.aria.programs.git.enable = lib.mkEnableOption "opinionated git defaults";

  config = lib.mkIf cfg.enable {
    environment.etc."gitignore_global" = {
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
          excludesFile = "/etc/gitignore_global";
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
      };
    };
  };
}
