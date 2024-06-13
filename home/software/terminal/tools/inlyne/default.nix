{
  pkgs,
  config,
  ...
}: let
  mde = pkgs.writeShellScriptBin "mde" ''
    if [ ! -f "$1" ]; then
      touch "$1"
    fi

    hx "$1" &
    inlyne "$1" &

    wait
  '';
  inherit (config.stylix) fonts;
  colors = config.stylix.base16Scheme;
in {
  home.packages = [pkgs.inlyne mde];
  home.file.".config/inlyne/inlyne.toml".text = ''
    theme = "Dark"
    [dark-theme]
        background-color = 0x${colors.base00}
        text-color = 0x${colors.base0E}
        code-color = 0x${colors.base0A}
        quote-block-color = 0x${colors.base0C}
        link-color = 0x${colors.base08}
    [font-options]
        regular-font = "${fonts.sansSerif.name}"
        monospace-font = "${fonts.monospace.name}"
  '';
}
