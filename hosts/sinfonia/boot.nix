{ lib, ... }:
{
  boot = {
    tmp = {
      useTmpfs = true;
      tmpfsSize = "100%";
    };

    loader = lib.mkDefault {
      timeout = 5;
    };

    consoleLogLevel = lib.mkDefault 7;
  };
}
