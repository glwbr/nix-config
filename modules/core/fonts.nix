{ config, lib, pkgs, ... }:
let
  cfg = config.aria.core.fonts;

  coreFonts = with pkgs; [ noto-fonts noto-fonts-cjk-sans noto-fonts-emoji nerd-fonts.jetbrains-mono ];
  designerFonts = with pkgs; [ inter roboto noto-fonts-extra source-code-pro ] ++ [ pkgs.sf-pro pkgs.sf-mono pkgs.ny ];
  basicFontconfig = {
    defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "JetBrainsMono NF" ];
    };
  };

  enhancedFontconfig = basicFontconfig // {
    defaultFonts = {
      serif = [ "NY" "Noto Serif" "Source Serif Pro" ];
      sansSerif = [ "Inter" "SF Pro Display" "Noto Sans" "Source Sans Pro" ];
      monospace = [ "SF Mono" "JetBrainsMono NF" "Source Code Pro" ];
    };
    antialias = true;
    hinting = {
      enable = true;
      style = "slight";
    };
    subpixel = {
      rgba = "rgb";
      lcdfilter = "default";
    };
  };
in
  {
  options.aria.core.fonts = {
    enable = lib.mkEnableOption "System fonts";

    includeDesignerFonts = lib.aria.mkBoolOpt false "Include (SF Pro, NY, Inter, etc.)";
    enableEnhancedRendering = lib.aria.mkBoolOpt false "Enable enhanced font rendering (subpixel, hinting)";
    extraFonts = lib.aria.mkListOpt lib.types.package [] "Additional fonts to install";
  };

  config = lib.mkIf cfg.enable {
    fonts = {
      enableDefaultPackages = false;
      fontconfig = if cfg.enableEnhancedRendering then enhancedFontconfig else basicFontconfig;
      packages = coreFonts ++ lib.optionals cfg.includeDesignerFonts designerFonts ++ cfg.extraFonts;
    };
  };
}
