{ config, lib, inputs, ... }:
let
  cfg = config.aria.security.sops;
in
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  options.aria.security.sops.enable = lib.mkEnableOption "SOPS secrets management";

  config = lib.mkIf cfg.enable {
    sops = {
      defaultSopsFile = ../../secrets/common.yaml;
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
  };
}
