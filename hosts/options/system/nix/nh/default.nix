{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.aria.system.nix.nh;
  inherit (lib.aria) mkBoolOpt;
in
{
  options.aria.system.nix.nh = {
    enable = mkBoolOpt false "Whether or not to enable nh.";
  };

  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      # weekly cleanup
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/glwbr/projects/nix-config";
    };

    environment.systemPackages = [
      #FIXME: remove after https://github.com/viperML/nh/pull/107
      (pkgs.writeScriptBin "snh" ''
        #!/bin/sh
        exec doas nh "$@" -R
      '')
    ];
  };
}
