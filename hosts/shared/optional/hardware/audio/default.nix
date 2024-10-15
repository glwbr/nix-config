{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.aria.hardware.audio;

  inherit (lib) types mkIf;
  inherit (lib.aria) mkBoolOpt mkOpt;
in
{
  options.aria.hardware.audio = with types; {
    enable = mkBoolOpt false "Whether or not to enable audio support.";
    extraPackages = mkOpt (listOf package) [
      pkgs.easyeffects
    ] "Additional packages to include with audio settings.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      with pkgs;
      [
        pulsemixer
      ]
      ++ cfg.extraPackages;

    aria.user.extraGroups = [ "audio" ];

    hardware.pulseaudio.enable = lib.mkForce false;

    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;

      wireplumber = {
        enable = true;
        configPackages = [
          (pkgs.writeTextDir "share/bluetooth.lua.d/51-bluez-config.lua" ''
            bluez_monitor.properties = {
              ["bluez5.enable-sbc-xq"] = true,
              ["bluez5.enable-msbc"] = true,
              ["bluez5.enable-hw-volume"] = true,
              ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
            }
          '')
        ];
      };
    };

  };
}
