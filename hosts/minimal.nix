{ lib, pkgs, ... }:
let
  inherit (lib.aria) disabled enabled;
in
{
  environment.defaultPackages = with pkgs; [
    neovim
    git
  ];

  aria = {
    security = {
      doas = enabled;
      polkit = enabled;
      pam = enabled;
      sops = enabled;
    };

    services = {
      dbus = enabled;
      openssh = enabled;
    };

    system = {
      boot = enabled;
      locale = enabled;
    };
  };

  programs.nano = disabled;
}
