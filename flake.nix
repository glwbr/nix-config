{
  description = "My own flake, my own Aria.";

  inputs = {
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hardware.url = "github:nixos/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nvim.url = "github:glwbr/nvim";
    apple-fonts.url = "github:glwbr/apple-fonts-flake";
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      nvim,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      lib = nixpkgs.lib.extend (final: prev: { aria = import ./lib { lib = final; }; });
      utils = import ./lib/utils.nix { inherit lib inputs outputs; };
    in
    {
      overlays = import ./overlays { inherit inputs outputs; };
      devShells = utils.forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });

      # 'nixos-rebuild --flake .#hostname'
      nixosConfigurations = {
        sonata = utils.mkSystem {
          hostname = "sonata";
          extraModules = [
            disko.nixosModules.disko
            nvim.nixosModule
          ];
        };
        sinfonia = utils.mkSystem {
          system = "aarch64-linux";
          hostname = "sinfonia";
          extraModules = [ nvim.nixosModules ];
        };
      };
    };
}
