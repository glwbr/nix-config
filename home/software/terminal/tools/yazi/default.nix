{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./theme/icons.nix
    ./theme/manager.nix
    ./theme/status.nix
  ];

  # General file info
  home.packages = [ pkgs.exiftool ];

  # yazi file manager
  programs.yazi = {
    enable = true;

    package = inputs.yazi.packages.${pkgs.system}.default;

    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
  };
}
