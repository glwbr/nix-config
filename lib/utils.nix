{ lib, inputs, outputs }:
rec {
  pkgsFor = lib.genAttrs (import inputs.systems) (system:
    import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    });

  forEachSystem = f: lib.genAttrs (import inputs.systems) (system: f pkgsFor.${system});

  mkSystem = { hostName, profile, system ? "x86_64-linux", extraModules ? [], stateVersion ? "24.11" }:
    lib.nixosSystem {
      inherit system;

      specialArgs = { inherit lib inputs outputs hostName; };

      modules = [
        ../modules
        ../profiles/base.nix
        ../hosts/${hostName}
        ../profiles/${profile}.nix
      ] ++ extraModules ++ [{ networking.hostName = hostName; system.stateVersion = stateVersion; }];
    };

  mkProfile = modules: { imports = modules; };

  # Module discovery
  importModules = path: lib.mapAttrsToList (name: type:
    if type == "directory" then path + "/${name}"
    else if lib.hasSuffix ".nix" name && name != "default.nix" then path + "/${name}"
    else null) (builtins.readDir path)
    |> builtins.filter (x: x != null);
}
