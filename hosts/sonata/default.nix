{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.hardware.nixosModules.dell-inspiron-7460
    ./boot.nix
    ./disko.nix
    ./hardware.nix
    ./stylix.nix

    ../shared/core
    ../shared/optional
  ];

  aria.dms.greetd.enable = true;

  networking.hostName = "sonata";
  nixpkgs.config.allowUnfree = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = lib.mkDefault "24.05";
  services.udisks2.enable = true;
}
