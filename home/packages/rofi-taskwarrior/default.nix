{ stdenv, rustPlatform, fetchFromGitHub, pkgconfig, ... }:

with rustPlatform;

buildRustPackage rec {
  crateName = "rofi-taskwarrior";
  version = "0.3.0";

  name = "${crateName}-${version}";

  cargoSha256 = "01yzll238dy0q4cd8rskiqzj4q471mwc25pmrqaw4slqs32kz2d8";

  src = fetchFromGitHub {
    owner = "nyarly";
    repo = crateName;
    rev = version;
    sha256 = "19knn3kh4h9ylwzw7ng6z3910cip18pvwy2y5dkrz9zdgbrzjl4s";
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
