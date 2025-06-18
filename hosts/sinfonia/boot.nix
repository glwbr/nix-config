{ lib, ... }:
{
  boot = {
    consoleLogLevel = lib.mkDefault 7;
    loader = lib.mkDefault { timeout = 5; };
    tmp = { useTmpfs = true; tmpfsSize = "100%"; };
  };
}
