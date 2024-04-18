{
  self,
  inputs,
  homeImports,
  ...
}: {
  flake.nixosConfigurations = let
    # shorten paths
    inherit (inputs.nixpkgs.lib) nixosSystem;
    mod = "${self}/system";

    # get the basic config to build on top of
    inherit (import "${self}/system") desktop laptop;

    # get these into the module system
    specialArgs = {inherit inputs self;};
  in {
    anchor = nixosSystem {
      inherit specialArgs;
      modules =
        desktop
        ++ laptop
        ++ [
          ./anchor
          {
            home-manager = {
              users.lonen.imports = homeImports."lonen@anchor";
              extraSpecialArgs = specialArgs;
            };
          }
          inputs.agenix.nixosModules.default
        ];
    };
  };
}
