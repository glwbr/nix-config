{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.hardware.nixosModules.dell-inspiron-7460
    ./hardware.nix
    ./stylix.nix
    ./disko.nix

    ../shared/core
    ../shared/optional
  ];

  aria.dms.greetd.enable = true;

  boot = {
    kernelModules = [ "v4l2loopback" ];
    kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  };

  networking.hostName = "sonata";
  nixpkgs.config.allowUnfree = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = lib.mkDefault "24.05";
  services.udisks2.enable = true;
}
