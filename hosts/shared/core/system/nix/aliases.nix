{
  shellAliases = {
    # nix
    nd = "nix develop -c $SHELL";
    ns = "nix shell";
    nb = "nix build";
    nf = "nix flake";
    nr = "nixos-rebuild --flake .";
    nui = "nix flake lock --update-input";
    snr = "sudo nixos-rebuild --flake .";

    bloat = "nix path-info -Sh /run/current-system";
    switch = "sudo nixos-rebuild --flake . switch";
    rebuild = "sudo nixos-rebuild --flake . test";

    # nix gc
    cleanup = "sudo nix-collect-garbage --delete-older-than 1d";
    listgen = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
    nixremove = "nix-store --gc";

    # nix packages
    installed = "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq | sk";
    installedall = "nix-store --query --requisites /run/current-system | sk";
  };
}
