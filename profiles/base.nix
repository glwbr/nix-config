{ lib, pkgs, ... }:
{
  documentation = {
    enable = lib.mkDefault false;
    man.enable = lib.mkDefault false;
    info.enable = lib.mkDefault false;
    nixos.enable = lib.mkDefault false;
  };

  programs.nano.enable = false;
  programs.command-not-found.enable = false;
  environment.defaultPackages = [ ];

  environment.systemPackages = with pkgs; [ curl git neovim ];

  networking.firewall.enable = true;
  networking.nftables.enable = true;

  time.timeZone = lib.mkDefault "America/Bahia";
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  aria = {
    core.enable = true;
    hardware.enable = true;
    programs.enable = true;
    security.enable = true;
    services.enable = true;
  };
}
