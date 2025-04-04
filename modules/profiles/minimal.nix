{
  config,
  lib,
  ...
}:
let
  inherit (lib.aria) disabled enabled mkBoolOpt;
  cfg = config.aria.profiles.minimal;
in
{
  options.aria.profiles.minimal = {
    enable = mkBoolOpt true "Wether to apply the minimal configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.nano = disabled;
    documentation = disabled;
    environment.defaultPackages = [ ];

    zramSwap = {
      enable = true;
      swapDevices = 1;
      algorithm = "zstd";
    };

    nvim = enabled;

    aria = {
      hardware = {
        wireless.iwd = enabled;
        input = enabled;
      };

      security.pam = enabled;

      services.openssh = enabled;

      terminal = {
        shell.zsh = enabled;

        tools = {
          direnv = enabled;
          git = enabled;
          tmux = enabled;
        };
      };

      system = {
        boot = enabled;
        locale = enabled;
        nix = enabled;
      };
    };
  };
}
