{
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.aria) disabled enabled;
in {
  imports = [
    ./boot.nix
    ./disko.nix
    ./hardware.nix
    inputs.hardware.nixosModules.dell-inspiron-7460
  ];

  aria = {
    profiles.desktop = enabled;
    users = {
      enable = true;
      defaultUserShell = pkgs.zsh;
      # extraGroups = [ "docker" "networkmanager" "podman" ];

      users.glwbr = {
        name = "glwbr";
        email = "hello@glwbr.me";
        fullName = "Glauber Santana";
        hashedPassword = "$y$j9T$gRWruTQzJkmoHO7AaStnb1$1QHo3o.vdl.64VV3ooLsUxs0DHTTMSrCMzY1Kl2FL61";
        extraGroups = ["wheel"];
        # sshKeys = [ ];
      };

      # root = {
      #  enable = true;
      #  hashedPassword = "$y$j9T$30Oc05fIuDihN/nyqBuuF.$XbJfwsdiI1CHcXLQ164mrk.rWvjdayWTWQiBmnlTVz3";
      # };
    };

    virtualisation = {
      podman = enabled;
    };

    wms.i3 = enabled;
  };

  environment.systemPackages = with pkgs; [alacritty];

  networking.hostName = "sonata";
  nixpkgs.config.allowUnfree = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = lib.mkDefault "24.05";
}
