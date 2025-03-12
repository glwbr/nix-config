{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt;
  alias = import ./aliases.nix;
  cfg = config.aria.tools.git;
in
{
  options.aria.tools.git = {
    enable = mkBoolOpt false "Whether to enable git";
  };

  config = mkIf cfg.enable {
    environment.etc."ignore" = {
      source = ./ignore;
      mode = "0644";
    };

    programs.git = {
      enable = true;
      lfs.enable = true;
      config = {
        inherit alias;

        init = {
          defaultBranch = "main";
        };

        checkout = {
          defaultRemote = "origin";
        };

        core = {
          editor = "nvim";
          excludesFile = "/etc/ignore";
          whitespace = "trailing-space,space-before-tab,indent-with-non-tab";
        };

        pull = {
          ff = "only";
          rebase = true;
        };

        rebase = {
          autoStash = true;
        };

        user = {
          name = "Glauber S. Santana";
          email = "hello@glwbr.me";
        };
      };
    };
  };

}
