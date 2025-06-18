{ config, lib, pkgs, ... }:
let
  cfg = config.aria.hardware.graphics;
in
{
  options.aria.hardware.graphics = {
    enable = lib.mkEnableOption "graphics options";
  };

  #INFO: only for sonata config (for now)
  config = lib.mkIf cfg.enable {
    boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [ nvidia-vaapi-driver vaapiVdpau libvdpau-va-gl intel-media-driver intel-media-sdk libva-utils libva vaapiIntel ];
    };

    hardware.nvidia = {
      open = false;
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement.enable = true;
    };
  };
}
