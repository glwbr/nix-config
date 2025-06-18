{ config, lib, pkgs, ... }:
let
  cfg = config.aria.hardware.audio;
in
{
  options.aria.hardware.audio = {
    enable = lib.mkEnableOption "audio system configuration";

    lowLatency = lib.aria.mkBoolOpt false "Enable low-latency audio configuration";
  };

  config = lib.mkIf cfg.enable {

    security.rtkit.enable = true;
    environment.systemPackages = with pkgs; [ pulsemixer pavucontrol ] ++ lib.optionals cfg.lowLatency [ qjackctl ];
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;

      extraConfig.pipewire = lib.mkIf cfg.lowLatency {
        "99-lowlatency" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.quantum" = 32;
            "default.clock.min-quantum" = 32;
            "default.clock.max-quantum" = 32;
          };
        };
      };

      wireplumber.enable = true;
      wireplumber.configPackages = lib.mkIf config.aria.hardware.bluetooth.enable [
        (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/50-bluez.conf" ''
          monitor.bluez.properties = {
            bluez5.enable-sbc-xq = true
            bluez5.enable-msbc = true
            bluez5.enable-hw-volume = true
            bluez5.roles = [ a2dp_sink a2dp_source bap_sink bap_source hsp_hs hsp_ag hfp_hf hfp_ag ]
          }
        '')
      ];
    };
  };
}
