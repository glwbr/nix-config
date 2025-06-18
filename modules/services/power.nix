{ config, lib, ... }:
let
  cfg = config.aria.services.power;
  inherit (lib.aria) mkBoolOpt mkOpt;
in
  {
  options.aria.services.power = {
    enable = lib.mkEnableOption "power management";

    profile = mkOpt (lib.types.enum [ "laptop" "desktop" "server" "embedded" ]) "server" "Power management profile";

    laptop = {
      enableTlp = mkBoolOpt true "Whether to enable TLP power management";
      lidSwitch = mkOpt lib.types.str "suspend" "Action on lid close";
      lidSwitchExternalPower = mkOpt lib.types.str "lock" "Action on lid close with external power";

      battery = {
        startChargeThreshold = mkOpt lib.types.int 20 "Battery start charge threshold";
        stopChargeThreshold = mkOpt lib.types.int 80 "Battery stop charge threshold";
      };
    };

    cpu = {
      governor = mkOpt lib.types.str "schedutil" "CPU frequency governor";
      governorOnAC = mkOpt lib.types.str "performance" "CPU governor when on AC power (laptop only)";
      governorOnBattery = mkOpt lib.types.str "powersave" "CPU governor when on battery (laptop only)";
    };

    enableThermald = mkBoolOpt true "Enable thermald daemon";
    enableGameMode = mkBoolOpt false "Enable GameMode for performance optimization";

    network = {
      wifiPowerSaveOnAC = mkBoolOpt false "Enable WiFi power saving on AC";
      wifiPowerSaveOnBattery = mkBoolOpt true "Enable WiFi power saving on battery";
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        services.upower.enable = cfg.profile != "server" && cfg.profile != "embedded";
        powerManagement.enable = true;
      }

      (lib.mkIf (cfg.profile == "laptop") {
        services = {
          logind = {
            lidSwitch = cfg.laptop.lidSwitch;
            lidSwitchExternalPower = cfg.laptop.lidSwitchExternalPower;
            powerKey = "suspend";
            powerKeyLongPress = "poweroff";
          };

          tlp = lib.mkIf cfg.laptop.enableTlp {
            enable = true;
            settings = {
              START_CHARGE_THRESH_BAT0 = cfg.laptop.battery.startChargeThreshold;
              STOP_CHARGE_THRESH_BAT0 = cfg.laptop.battery.stopChargeThreshold;

              CPU_SCALING_GOVERNOR_ON_AC = cfg.cpu.governorOnAC;
              CPU_SCALING_GOVERNOR_ON_BAT = cfg.cpu.governorOnBattery;

              WIFI_PWR_ON_AC = if cfg.network.wifiPowerSaveOnAC then "on" else "off";
              WIFI_PWR_ON_BAT = if cfg.network.wifiPowerSaveOnBattery then "on" else "off";

              USB_AUTOSUSPEND = 1;

              SOUND_POWER_SAVE_ON_AC = 0;
              SOUND_POWER_SAVE_ON_BAT = 1;
            };
          };

          # Use power-profiles-daemon if TLP is disabled
          power-profiles-daemon.enable = !cfg.laptop.enableTlp;
          thermald.enable = cfg.enableThermald;
        };

        # Set CPU governor when not using TLP
        powerManagement.cpuFreqGovernor = lib.mkIf (!cfg.laptop.enableTlp) cfg.cpu.governor;
      })

      (lib.mkIf (cfg.profile == "desktop") {
        services = {
          power-profiles-daemon.enable = true;
          thermald.enable = cfg.enableThermald;
        };

        programs.gamemode.enable = cfg.enableGameMode;
        powerManagement.cpuFreqGovernor = cfg.cpu.governor;
      })

      (lib.mkIf (cfg.profile == "server") {
        powerManagement = {
          enable = true;
          cpuFreqGovernor = cfg.cpu.governor;
        };

        services = {
          thermald.enable = cfg.enableThermald;
          power-profiles-daemon.enable = false;
        };
      })

      (lib.mkIf (cfg.profile == "embedded") {
        powerManagement = {
          enable = true;
          cpuFreqGovernor = cfg.cpu.governor;
        };

        services = {
          thermald.enable = cfg.enableThermald;
          power-profiles-daemon.enable = false;
        };
      })
    ]
  );
}
