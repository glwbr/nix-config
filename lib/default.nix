{ lib }:
rec {
  mkOpt = type: default: description: lib.mkOption { inherit type default description; };

  mkBoolOpt = mkOpt lib.types.bool;
  mkListOpt = elemType: mkOpt (lib.types.listOf elemType);

  enabled = { enable = true; };
  disabled = { enable = false; };

  mkService = { name, description, after ? [], wants ? [], ... }: {
    systemd.services.${name} = {
      inherit description after wants;
      wantedBy = [ "multi-user.target" ];
    };
  };
}
