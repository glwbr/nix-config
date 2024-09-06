{lib, ...}: {
  programs.kitty = {
    enable = true;
    font = lib.mkForce {
      name = "JetBrainsMono NF Light";
      size = 16;
    };
  };
}
