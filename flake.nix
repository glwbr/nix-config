{
  description = "My own flake, my own Aria.";

  inputs = {
    corgix.url = "github:glwbr/corgix";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hardware.url = "github:nixos/nixos-hardware";

    impermanence.url = "github:nix-community/impermanence";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      hm,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib.extend (prev: _: { aria = import ./lib/default.nix { lib = prev; }; } // hm.lib);

      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];

      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );
    in
    {
      inherit lib;

      # homeManagerModules = import ./modules/home;
      # nixosModules = import ./modules/nixos;
      overlays = import ./overlays { inherit inputs outputs; };

      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      formatter = forEachSystem (pkgs: pkgs.nixfmt-rfc-style);
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });

      # 'nixos-rebuild --flake .#hostname'
      nixosConfigurations = {
        sonata = lib.nixosSystem {
          modules = [
            ./hosts/sonata
            disko.nixosModules.default
          ];
          specialArgs = {
            inherit inputs outputs;
          };
        };

        sinfonia = lib.nixosSystem {
          modules = [
            ./hosts/sinfonia
            disko.nixosModules.default
          ];
          specialArgs = {
            inherit inputs outputs;
          };
        };

      };

      # 'home-manager --flake .#username@hostname'
      homeConfigurations = {
        "glwbr@sonata" = lib.homeManagerConfiguration {
          extraSpecialArgs = {
            inherit inputs outputs lib;
          };
          modules = [ ./home/glwbr/sonata.nix ];
          pkgs = pkgsFor.x86_64-linux;
        };
      };
    };
}
