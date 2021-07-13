{ stdenv, lib, rustPlatform, fetchFromGitHub, pkgconfig, ... }:

with rustPlatform;

buildRustPackage rec {
  crateName = "confit";
  version = "1.0.0";

  name = "${crateName}-${version}";

  cargoSha256 = "sha256-lCPHzrjTeK3pOMxWOqkqZyMCrNdyB5JJtf7VxMX5g2k=";

  src = fetchFromGitHub {
    owner = "nyarly";
    repo = crateName;
    rev = version;
    hash = "sha256-XNKVzQZ+noat7f9w5POzpMb/2Zm5r7xM1SzB3hdSA1Q=";
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
