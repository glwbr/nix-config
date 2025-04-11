{
  lib,
  inputs,
  outputs,
  ...
}:
let
  systems = inputs.systems;

  nixpkgs = inputs.nixpkgs;

  pkgsFor = lib.genAttrs systems (
    system:
    import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    }
  );

  mkSystem =
    {
      hostname,
      system ? "x86_64-linux",
      extraModules ? [ ],
    }:
    lib.nixosSystem {
      inherit system;
      modules = [
        ../hosts/${hostname}
        ../modules
      ] ++ extraModules;
      specialArgs = { inherit lib inputs outputs; };
    };

  forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
in
{
  inherit mkSystem pkgsFor forEachSystem;
}
