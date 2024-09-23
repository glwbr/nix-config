_: {
  imports = [
    ./nix
    ./sops

    ./boot.nix
    ./fonts.nix
    ./locale.nix
    ./minimal.nix
    ./openssh.nix
    ./security.nix
    ./users.nix
  ];

  services = {
    dbus.implementation = "broker";

    # profile-sync-daemon
    psd = {
      enable = true;
      resyncTimer = "10m";
    };
  };
}
