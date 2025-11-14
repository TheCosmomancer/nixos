{ stdenv, lib }:

stdenv.mkDerivation rec {
  pname = "duck-plymouth-theme";
  version = "2.0";

  src = ./.;

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/share/plymouth/themes/duck
    cp -r ./source/* $out/share/plymouth/themes/duck/
    
    runHook postInstall
  '';

  meta = with lib; {
    description = "duck plymouth theme";
    # license = licenses.mit;
    platforms = platforms.linux;
  };
}