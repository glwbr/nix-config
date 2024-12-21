{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.aria) disabled enabled;
in {
  environment.defaultPackages = with pkgs; [ git neovim ];

  aria = {
    security = {
      doas = {
        enable = true;
        noPass = true;
      };
      pam = enabled;
      # sops = enabled;
    };

    services = {
      openssh = enabled;
    };

    system = {
      boot = enabled;
      locale = enabled;
    };
  };

  programs.nano = disabled;
}
