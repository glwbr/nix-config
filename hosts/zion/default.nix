{inputs, ...}: {
  imports = [
    ./disko.nix
    ./hardware.nix
    ./powersave.nix
    ./stylix.nix

    ../shared/core/sops
    ../shared/optional/services/pipewire

    # Move this to flake modules inputs
    inputs.disko.nixosModules.disko
  ];

  boot = {
    # Load modules on boot
    kernelModules = ["v4l2loopback"];
    kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];
  };

  networking.hostName = "zion";
  services.fstrim.enable = true;
}
