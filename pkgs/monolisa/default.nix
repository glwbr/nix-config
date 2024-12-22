{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation {
  pname = "monolisa";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "glwbr";
    repo = "Monolisa";
    rev = "ffedc6f7110c0cca9ee20841b381830aaf79aa07";
    hash = "sha256-nz8NAeoprQ7OeFfs+7ixd6EFJyJV35WZK4mAS5izn8k=";
  };

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -R $src $out/share/fonts/truetype/
  '';

  meta = with lib; {
    description = "Monolisa Fonts";
    homepage = "https://github.com/glwbr/Monolisa";
    license = licenses.mit;
    maintainers = [maintainers.glwbr];
  };
}
