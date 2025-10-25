{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  fetchgit,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  name = "aic8800-firmware";
  version = "0-unstable";

  src = fetchFromGitHub {
    owner = "deepin-community";
    repo = "aic8800";
    rev = "a961e558325e8a32720ade0269a004ff24dc1872";
    hash = "sha256-YXdBN2uuy9Ulxw9vRg87F8yyWXUD0ZvhvHCE+EFO5Xs=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/firmware/aic8800_fw/
    cp -rv firmware/* $out/lib/firmware/aic8800_fw/

    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/radxa-pkg/aic8800";
    description = "Aicsemi aic8800 Wi-Fi driver firmware";
    # https://github.com/radxa-pkg/aic8800/issues/54
    license = with lib.licenses; [
      gpl2Only
    ];
    maintainers = with lib.maintainers; [ Cryolitia ];
    platforms = lib.platforms.linux;
  };
})
