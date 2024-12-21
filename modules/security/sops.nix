{
  config,
  lib,
  inputs,
  ...
}: let
  inherit (lib) types;
  inherit (lib.aria) mkBoolOpt mkOpt;

  cfg = config.aria.security.sops;
  getKeyPath = k: k.path;
  isEd25519 = k: k.type == "ed25519";
  keys = builtins.filter isEd25519 config.services.openssh.hostKeys;
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  options.aria.security.sops = with types; {
    enable = mkBoolOpt false "Whether to enable sops";
    defaultSopsFile = mkOpt path null "Default sops file.";
    sshKeyPaths = mkOpt (listOf path) ["/etc/ssh/ssh_host_ed25519_key"] "SSH Key paths to use.";
  };

  config = lib.mkIf cfg.enable {
    sops = {
      age.sshKeyPaths = map getKeyPath keys;
      inherit (cfg) defaultSopsFile;
    };
  };
}
