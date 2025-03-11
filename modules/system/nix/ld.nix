{
  config,
  lib,
  ...
}:
let
  inherit (lib.aria) mkBoolOpt;
  cfg = config.aria.system.nix.nh;
in
{
  options.aria.system.nix.ld = {
    enable = mkBoolOpt false "Whether or not to enable nix-ld";
  };

  config = lib.mkIf cfg.enable {
    programs.nix-ld.enable = true;
  };
}
