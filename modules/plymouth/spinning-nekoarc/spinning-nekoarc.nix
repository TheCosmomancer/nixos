{ stdenv, lib }:

stdenv.mkDerivation rec {
  pname = "spinning-nekoarc-plymouth-theme";
  version = "1.0";

  src = ./.;

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/share/plymouth/themes/spinning-nekoarc
    cp -r ./source/* $out/share/plymouth/themes/spinning-nekoarc/
    
    runHook postInstall
  '';

  meta = with lib; {
    description = "spinning nekoarc plymouth theme";
    # license = licenses.mit;
    platforms = platforms.linux;
  };
}