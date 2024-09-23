{
  pkgs,
  config,
  ...
}:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  sops.secrets.glwbr-passwd = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
  };

  programs.zsh.enable = true;
  users.mutableUsers = false;
  users.users.glwbr = {
    description = "Glauber Santana";
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups =
      [
        "wheel"
        "video"
        "audio"
      ]
      ++ ifTheyExist [
        "adbusers"
        "network"
        "networkmanager"
        "wireshark"
        "docker"
        "podman"
        "git"
        "libvirtd"
      ];

    hashedPasswordFile = config.sops.secrets.glwbr-passwd.path;
    openssh.authorizedKeys.keys = [ ];
  };
}
