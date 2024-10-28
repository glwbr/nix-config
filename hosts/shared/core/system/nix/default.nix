{
  inputs,
  lib,
  outputs,
  ...
}:
let
  aliases = import ./aliases.nix;
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in
{
  imports = [
    ./nh
    ./substituters.nix
  ];

  nix = {
    # pin the registry to avoid re-downloading a nixpkgs version
    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;

    # set the path for channels compat
    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") flakeInputs;

    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
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

    # TODO: run build from Pi to laptop with distributedBuilds

    gc = {
      automatic = false;
      dates = "weekly";
      options = "--delete-older-than +3";
    };
  };

  nixpkgs.overlays = builtins.attrValues outputs.overlays;
  environment = {
    inherit (aliases) shellAliases;
  };
}
