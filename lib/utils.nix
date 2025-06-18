{ lib, inputs, outputs }:
rec {
  pkgsFor = lib.genAttrs (import inputs.systems) (system:
    import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    });

  forEachSystem = f: lib.genAttrs (import inputs.systems) (system: f pkgsFor.${system});

  mkSystem = { hostName, profile, system ? "x86_64-linux", extraModules ? [] }:
    lib.nixosSystem {
      inherit system;
      modules = [ ../modules ../profiles/base.nix ../hosts/${hostName} ../profiles/${profile}.nix ] ++ extraModules;
      specialArgs = { inherit lib inputs outputs hostName; };
    };

  mkProfile = modules: { imports = modules; };

  # Module discovery
  importModules = path: lib.mapAttrsToList (name: type:
    if type == "directory" then path + "/${name}"
    else if lib.hasSuffix ".nix" name && name != "default.nix" then path + "/${name}"
    else null) (builtins.readDir path) 
    |> builtins.filter (x: x != null);
}
