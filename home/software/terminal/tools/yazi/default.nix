{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.aria) mkBoolOpt;
  cfg = config.aria.programs.terminal.tools.yazi;
in {
  options.aria.programs.terminal.tools.yazi = {
    enable = mkBoolOpt false "Whether or not to enable yazi.";
  };

  imports = [
    ./theme/icons.nix
    ./theme/manager.nix
    ./theme/status.nix
  ];

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      catimg
      exiftool
      ffmpegthumbnailer
      imagemagick
      ueberzugpp
    ];

    programs.yazi = {
      enable = true;
      package = pkgs.inputs.yazi.default;

      enableBashIntegration = config.programs.bash.enable;
      enableZshIntegration = config.programs.zsh.enable;
    };
  };
}
