{ pkgs, ... }:
{
  environment.defaultPackages = with pkgs; [
    neovim
    git
  ];
  programs.nano.enable = false;
}
