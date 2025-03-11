{
  config,
  lib,
  ...
}:
let
  inherit (lib) types;
  inherit (lib.aria) mkBoolOpt mkOpt;
  cfg = config.aria.system.xkb;
in
{
  options.aria.system.xkb = with types; {
    enable = mkBoolOpt false "Whether to enable xkb settings";
    layout = mkOpt str "us,us" "Keyboard layouts to use";
    options =
      mkOpt str "caps:swapescape,grp:alt_space_toggle"
        "XKB options like caps key behavior and layout switching";
    variant = mkOpt str ",intl" "Keyboard variants for the layouts";
  };

  config = lib.mkIf cfg.enable {
    console = lib.mkForce {
      useXkbConfig = true;
      keyMap = "us";
    };

    services.xserver.xkb = {
      variant = cfg.variant;
      options = cfg.options;
      layout = cfg.layout;
    };
  };
}
