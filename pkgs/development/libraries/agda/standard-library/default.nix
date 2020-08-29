{ stdenv, mkDerivation, fetchFromGitHub, ghcWithPackages }:

mkDerivation rec {
  pname = "standard-library";

  src = fetchFromGitHub {
    repo = "agda-stdlib";
    owner = "agda";
    rev = "409af12828e2c6ff295a197b41fc6896cbfb0b6d";
    sha256 = "0l9pc8pvix9q7bb5hjijvvnv09gc2fvv1x8s1zyn5h94fak0l9xl";
  };

  nativeBuildInputs = [ (ghcWithPackages (self : [ self.filemanip ])) ];
  preConfigure = ''
    runhaskell GenerateEverything.hs
  '';

  meta = with stdenv.lib; {
    homepage = "https://wiki.portal.chalmers.se/agda/pmwiki.php?n=Libraries.StandardLibrary";
    description = "A standard library for use with the Agda compiler";
    license = stdenv.lib.licenses.mit;
    platforms = stdenv.lib.platforms.unix;
    maintainers = with maintainers; [ jwiegley mudri alexarice turion ];
  };
}
