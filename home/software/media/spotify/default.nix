{
  inputs,
  pkgs,
  config,
  ...
}: let
  variant =
    if config.stylix.polarity == "light"
    then "latte"
    else "mocha";
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  imports = [inputs.spicetify-nix.homeManagerModule];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.Catppuccin;
    colorScheme = variant;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      fullAppDisplay
      fullAlbumDate
      hidePodcasts
      historyShortcut
      playlistIcons
      shuffle
    ];
  };
}
