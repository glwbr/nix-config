{pkgs, ...}: {
  monolisa = pkgs.callPackage ./monolisa {};
  wl-ocr = pkgs.callPackage ./wl-ocr {};
}
