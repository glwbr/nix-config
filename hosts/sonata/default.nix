{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.aria) enabled;
in
{
  imports = [
    ./boot.nix
    ./disko.nix
    ./hardware.nix
    ./stylix.nix

    ../minimal.nix
    ../options

    inputs.hardware.nixosModules.dell-inspiron-7460
  ];

  aria = {
    dms.greetd = enabled;
    hardware = {
      audio = enabled;
      bluetooth = enabled;
      logitech = enabled;
      serial = enabled;
    };

    system = {
      boot = {
        enable = true;
        plymouth = true;
        silentBoot = true;
      };

      fonts = enabled;
      locale = enabled;

      nix = {
        nh = enabled;
        ld = enabled;
      };
      xkb = enabled;
    };

    virtualisation = {
      docker = enabled;
      podman = enabled;
    };

    wireless.supplicant = enabled;
    wms.hyprland = enabled;
  };

  networking.hostName = "sonata";
  networking.hosts = {
    "127.0.0.1" = [ "local.svn.com.br" ];
  };

  nixpkgs.config.allowUnfree = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = lib.mkDefault "24.05";
}
