{ config, inputs, lib, outputs, ... }:
let
  cfg = config.aria.core.nix.daemon;
  nhCfg = config.aria.core.nix.nh;
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in
{
  options.aria.core.nix.daemon = {
    enable = lib.mkEnableOption "nix configuration management";
  };

  imports = [ ./substituters.nix ];

  config = lib.mkIf cfg.enable {
    # NOTE: pin the registry to avoid re-downloading a nixpkgs version
    nix.registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nix.nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") flakeInputs;

    nix.gc = lib.mkIf (!nhCfg.enable) {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    nix.settings = {
      warn-dirty = false;
      auto-optimise-store = false;
      builders-use-substitutes = true;

      trusted-users = [ "@wheel" ];
      flake-registry = "/etc/nix/registry.json";
      system-features = [ "kvm" "big-parallel" "nixos-test" ];
      experimental-features = [ "nix-command" "flakes" "ca-derivations" "pipe-operators" ];
    };

    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = builtins.attrValues outputs.overlays;
  };
}
