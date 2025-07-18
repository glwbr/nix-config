{ config, lib, pkgs, ... }: let
  cfg = config.aria.desktop.hyprland;
in
{
  options.aria.desktop.hyprland.enable = lib.mkEnableOption "hyprland";

  config = lib.mkIf cfg.enable {
    environment.variables = {
    XCURSOR_SIZE = "24";

    XCURSOR_THEME = "WhiteSur-cursors";
    #   NIXOS_OZONE_WL = "1";

    # Wayland-related platform hints
    #   EGL_PLATFORM = "wayland";
    #   OZONE_PLATFORM = "wayland";
    #   SDL_VIDEODRIVER = "wayland";
    #   ELECTRON_OZONE_PLATFORM_HINT = "wayland";

    # Qt environment for Wayland
    #   QT_QPA_PLATFORM = "wayland;xcb";
    #   QT_QPA_PLATFORMTHEME = "qt6ct";
    #   QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    #   QT_AUTO_SCREEN_SCALE_FACTOR = "1";

    # NVIDIA driver/Prime settings
    #   GBM_BACKEND = "nvidia-drm";
    #   LIBVA_DRIVER_NAME = "nvidia";
    #   __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    #   __NV_PRIME_RENDER_OFFLOAD = 1;
    #   __VK_LAYER_NV_optimus = "NVIDIA_only";

    # Miscellaneous
    #   WLR_DRM_NO_ATOMIC = 1;

    # Firefox (Mozilla) settings
    #   MOZ_DISABLE_RDD_SANDBOX = 1;
    #   MOZ_ENABLE_WAYLAND = 1;
    };

    hardware.brillo.enable = true;
    services.hypridle.enable = true;
    programs.hyprlock.enable = true;

    programs.hyprland = {
      enable = true;
      withUWSM = false;
      xwayland.enable = true;
    };

    services = {
      xserver.enable = true;
      xserver.desktopManager.xterm.enable = false;
      displayManager = {
        sddm = {
          enable = true;
          enableHidpi = true;
          wayland.enable = true;
        };
        defaultSession = "hyprland";
        #INFO: Enable full range of RGB values on HDMI connector (107)
        preStart = "${pkgs.libdrm.bin}/bin/proptest -M i915 -D /dev/dri/card0 107 connector 103 1";
      };
    };

    environment.pathsToLink = [ "/libexec" ];
    environment.systemPackages = with pkgs; [
      rofi
      dunst
      waybar
      socat
      swaylock
      grimblast
      hyprpaper
      libnotify
      way-displays
      wl-clipboard
      whitesur-cursors
    ];

    xdg.portal = {
      enable = true;
      config.hyprland.default = [ "hyprland" "gtk" ];
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-hyprland ];
    };
  };
}
