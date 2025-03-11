{
  config,
  inputs,
  lib,
  outputs,
  ...
}:
let
  inherit (lib.aria) mkBoolOpt;
  cfg = config.aria.system.nix;
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in
{
  options.aria.system.nix = {
    enable = mkBoolOpt false "Whether or not to manage nix configs";
  };

  imports = [ ./substituters.nix ];

  config = lib.mkIf cfg.enable {
    nix = {
      # NOTE: pin the registry to avoid re-downloading a nixpkgs version
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;

      # NOTE: set the path for channels compat
      nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") flakeInputs;

      settings = {
        auto-optimise-store = true;
        builders-use-substitutes = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        flake-registry = "/etc/nix/registry.json";
        system-features = [
          "kvm"
          "big-parallel"
          "nixos-test"
        ];
        trusted-users = [
          "root"
          "@wheel"
        ];
        warn-dirty = false;
      };
    };

    nixpkgs.overlays = builtins.attrValues outputs.overlays;
  };
}
