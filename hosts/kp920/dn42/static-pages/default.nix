{
  stdenvNoCC,
  typst,
}:

stdenvNoCC.mkDerivation {
  pname = "cryolitia-static-pages";
  version = "0.1";

  src = ./.;

  nativeBuildInputs = [ typst ];

  buildPhase = ''
    runHook preBuild

    find ./ -name "*.typ" -exec typst compile {} --format html --features html \;

    runHook postBuild
  '';

  installPhase = ''
    runHook preBuild

    install -Dv -m 644 *.html -t $out/share/cryolitia-static-pages/

    runHook postBuild
  '';
}
