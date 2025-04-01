{ inputs, ... }:
{

  apple-fonts = import ./apple-fonts.nix { inherit inputs; };
  flake-inputs = import ./flake-inputs.nix { inherit inputs; };

  # lib-aria = final: prev: {
  #   lib = prev.lib // (import ../lib { inherit lib; });
  # };
}
