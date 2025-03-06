{ lib, inputs, outputs, ... }:
let
  systems = [ "aarch64-linux" "x86_64-linux" ];
  nixpkgs = inputs.nixpkgs;
in
rec {

  mkSystem = { 
    hostname,
    system ? "x86_64-linux", 
    extraModules ? [],
  }: lib.nixosSystem {
    inherit system;
    modules = [ ../hosts/${hostname} ../modules inputs.disko.nixosModules.default ];
    specialArgs = { inherit lib inputs outputs; };
  };

	pkgsFor = lib.genAttrs systems (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );


  forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});

      }
