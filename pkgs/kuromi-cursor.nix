{ stdenv, fetchurl }:

stdenv.mkDerivation {
  pname = "kuromi-cursor";
  version = "2.0";

  src = fetchurl {
    url = "https://github.com/rockman6554/kuromi-cursor-linux/releases/download/2.0/kuromi-cursor.tgz";
    sha256 = "OK9rUmaeRnwt2l7ruEXLztnriVvraB9Q417K/lNogRc=";
  };

  # The tarball extracts to a folder named "kuromi-cursor"
  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/share/icons
    cp -r Kuromi-cursor $out/share/icons/
  '';
}
