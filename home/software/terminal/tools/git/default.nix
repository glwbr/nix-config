{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.aria.programs.terminal.tools.git;
  aliases = import ./aliases.nix;
  ignores = import ./ignores.nix;
  inherit (config.home) homeDirectory;
  inherit (lib.aria) mkOpt mkBoolOpt;
in
{
  options.aria.programs.terminal.tools.git = {
    enable = mkEnableOption "git";
    userName = mkOpt types.str "Glauber Santana" "The name to configure git with.";
    userEmail = mkOpt types.str "hello@glwbr.me" "The email to configure git with.";
    signByDefault = mkBoolOpt true "Whether to sign commits by default.";
    signingKey = mkOpt types.str "${homeDirectory}/.ssh/id_ed25519" "The key ID to sign commits with.";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;

      inherit (cfg) userName userEmail;
      inherit (aliases) aliases;
      inherit (ignores) ignores;

      delta = {
        enable = true;
        options = {
          dark = true;
          features = mkForce "decorations side-by-side navigate";
          line-numbers = true;
          navigate = true;
          side-by-side = true;
        };
      };

      extraConfig = {
        core.editor = "nvim";
        diff.colorMoved = "default";
        init.defaultBranch = "main";
        merge.conflictstyle = "diff3";
        pull.ff = "only";
        pull.rebase = true;
        push.autoSetupRemote = true;
        push.default = "current";
        rebase.autoStash = true;
        repack.usedeltabaseoffset = "true";
        # https://git-scm.com/book/en/v2/Git-Tools-Rerere
        rerere.enabled = true;
        rerere.autoupdate = true;
      };
      lfs.enable = true;
      signing = {
        key = cfg.signingKey;
        signByDefault = false;
      };
    };

    home = {
      inherit (aliases) shellAliases;
    };
  };
}
