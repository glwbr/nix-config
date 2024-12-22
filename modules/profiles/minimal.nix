{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.aria) disabled enabled mkBoolOpt;

  cfg = config.aria.profiles.minimal;
in {
  options.aria.profiles.minimal = {
    enable = mkBoolOpt false "Whether to enable minimal profile";
  };

  config = lib.mkIf cfg.enable {
    environment.defaultPackages = with pkgs; [git neovim];

    aria = {
      hardware = {
        wireless.iwd = enabled;
      };

      security = {
        doas = {
          enable = true;
          noPass = true;
        };
        pam = enabled;
      };

      services = {
        openssh = enabled;
      };

      shell = {
        zsh = enabled;
      };

      system = {
        boot = enabled;
        locale = enabled;
        nix = {
          nh = enabled;
        };
        xkb = enabled;
      };
    };

    programs.nano = disabled;
  };
}
