{ stdenv, lib }:

stdenv.mkDerivation rec {
  pname = "cosmomancers-collection-of-plymouth-themes";
  version = "1.0";

  src = ./.;

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/share/plymouth/themes/mytheme
    cp -r ./themes/* $out/share/plymouth/themes/mytheme/
    
    runHook postInstall
  '';

  meta = with lib; {
    description = "Cosmomancers collection of plymouth themes";
    # license = licenses.mit;
    platforms = platforms.linux;
  };
}