{
  pkgs,
  inputs,
  ...
}: {
  home.shellAliases.v = "nvim";
  home.packages = [inputs.corgix.packages.${pkgs.system}.default];
}
