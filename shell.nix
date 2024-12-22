{pkgs ? import <nixpkgs> {}, ...}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes ca-derivations";
    nativeBuildInputs = with pkgs; [
      age
      git
      gnupg
      home-manager
      nix
      neovim
      ripgrep
      ssh-to-age
      sops
    ];
  };
}
