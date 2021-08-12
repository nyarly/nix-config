{ stdenv, lib, rustPlatform, fetchFromGitHub, pkgconfig, ... }:

with rustPlatform;

buildRustPackage rec {
  crateName = "confit";
  version = "1.1.0";

  name = "${crateName}-${version}";

  cargoSha256 = "sha256-cD3TXo8FFu4XgaEn7ar+dUB4okunV87zZoxHN+jrgyw=";

  src = fetchFromGitHub {
    owner = "nyarly";
    repo = crateName;
    rev = version;
    hash = "sha256-WkOAWK57dcPUAtM8zbDVVzGw5SPKVl+ksHRBAFMVcTI=";
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
