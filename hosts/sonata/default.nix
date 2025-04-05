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
    inputs.hardware.nixosModules.dell-inspiron-7460
  ];

  nvim = enabled;

  aria = {
    profiles.desktop = enabled;
    users = {
      enable = true;
      defaultUserShell = pkgs.zsh;

      users.glwbr = {
        name = "glwbr";
        email = "hello@glwbr.me";
        fullName = "Glauber Santana";
        hashedPassword = "$y$j9T$gRWruTQzJkmoHO7AaStnb1$1QHo3o.vdl.64VV3ooLsUxs0DHTTMSrCMzY1Kl2FL61";
        extraGroups = [ "wheel" ];
        sshKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOw9mnJmXKHKGvkdlSHJ7dFP2XhlKvQbKogHxwBXFg9o"
        ];
        extraOptions = {
          packages = with pkgs; [
            firefox
            google-chrome
            spotify
            (discord.override { withVencord = true; })
          ];
        };
      };
    };

    virtualisation = {
      docker = enabled;
    };

    services.gpg = enabled;
    wms.i3 = enabled;
  };

  networking.hostName = "sonata";
  nixpkgs.config.allowUnfree = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = lib.mkDefault "24.05";
}
