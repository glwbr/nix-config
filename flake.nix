{
  description = "My own flake, my own Aria.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    hardware.url = "github:nixos/nixos-hardware";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nvim.url = "github:glwbr/nvim";
    sops-nix.url = "github:Mic92/sops-nix";
    apple-fonts.url = "github:glwbr/apple-fonts-flake";
    systems.url = "github:nix-systems/default-linux";
  };

  outputs = { self, nixpkgs, disko, nvim, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib.extend (final: prev: { aria = import ./lib { lib = final; }; });
      utils = import ./lib/utils.nix { inherit lib inputs outputs; };
    in {
      overlays = import ./overlays { inherit inputs outputs; };
      devShells = utils.forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });

      # 'nixos-rebuild --flake .#hostName'
      nixosConfigurations = {
        # Dell Inspiron 7460
        sonata = utils.mkSystem {
          profile = "laptop";
          hostName = "sonata";
          extraModules = [ disko.nixosModules.disko nvim.nixosModule ];
        };

        # OrangePi 3B
        sinfonia = utils.mkSystem {
          profile = "minimal";
          hostName = "sinfonia";
          system = "aarch64-linux";
          extraModules = [ nvim.nixosModule ];
        };
      };
    };
}
