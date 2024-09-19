{
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    packages = {
      wl-ocr = pkgs.callPackage ./wl-ocr {};
    };
  };
}
