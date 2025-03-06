{ lib, ... }:
let
  inherit (lib) mkOption types;
in
rec {
  mkOpt =
    type: default: description:
    mkOption { inherit type default description; };

  mkBoolOpt = mkOpt types.bool;

  enabled = {
    enable = true;
  };

  disabled = {
    enable = false;
  };
}
