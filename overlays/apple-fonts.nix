{ inputs, ... }:
final: prev: {
  ny = inputs.apple-fonts.packages.${prev.system}.ny;
  sf-pro = inputs.apple-fonts.packages.${prev.system}.sf-pro;
  sf-mono = inputs.apple-fonts.packages.${prev.system}.sf-mono;
  sf-mono-liga = inputs.apple-fonts.packages.${prev.system}.sf-mono-liga;
}
