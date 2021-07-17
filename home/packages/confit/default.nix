{ stdenv, lib, rustPlatform, fetchFromGitHub, pkgconfig, ... }:

with rustPlatform;

buildRustPackage rec {
  crateName = "confit";
  version = "1.0.2";

  name = "${crateName}-${version}";

  cargoSha256 = "sha256-EOAAXN2AFvMyr2+ToSaTmiR3I+tTSd7pxUIA5u+GsNQ=";

  src = fetchFromGitHub {
    owner = "nyarly";
    repo = crateName;
    rev = version;
    hash = "sha256-53ghI2La/mE/c6Ct6YMc9jfQCnAv7bdfIDRAE7Rufm0=";
  };

  nativeBuildInputs = [ pkgconfig ];

  meta = with lib; {
    description = "Makes sure your work is properly preserved";
    longDescription = ''
      A command line tool to check that git workplaces are properly
      preserved: that files are tracked, committed, tagged, and on a branch that
      tracks a remote, is pushed there.
    '';
    homepage = https://crates.io/crates/confit;
    license = licenses.mit; # before submission, need indiecc in nixpkgs
    maintainers = [ maintainers.nyarly ];
  };
}
