{ stdenv, rustPlatform, fetchFromGitHub, pkgconfig, ... }:

with rustPlatform;

buildRustPackage rec {
  crateName = "rofi-taskwarrior";
  version = "0.1.1";

  name = "${crateName}-${version}";

  cargoSha256 = "1x24mfkic9w4sra5w8pd70kgr1pzrykkxfcnvbdyg3gr1c4annbf";

  src = fetchFromGitHub {
    owner = "nyarly";
    repo = crateName;
    rev = version;
    sha256 = "1b3a48m9f9j5rc2yv68gli3xizmbnb7gb92qjfvv3jgf4n0c1vl5";
  };

  nativeBuildInputs = [ pkgconfig ];

  meta = with stdenv.lib; {
    description = "Rofi modi for Taskwarrior";
    longDescription = ''
      A rofi wrapper for taskwarrior. Provides a rofi-script modi,
      so that you can review, start, stop, edit and mark tasks done.
    '';
    homepage = https://crates.io/crates/rofi-taskwarrior;
    license = licenses.mit; # before submission, need prosperity60 in nixpkgs
    maintainers = [ maintainers.nyarly ];
  };
}
