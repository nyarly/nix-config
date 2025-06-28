{ lib, rustPlatform, fetchFromGitHub, pkg-config, ... }:

with rustPlatform;

buildRustPackage rec {
  crateName = "rofi-taskwarrior";
  version = "0.4.0";

  name = "${crateName}-${version}";

  cargoHash = "sha256-ilxMvJqJl382Qm0kKvJRuhzyf+TDgy2ugYx7Od66h+0=";

  src = fetchFromGitHub {
    owner = "nyarly";
    repo = crateName;
    rev = version;
    sha256 = "sha256-Q/hgM/etexjMrulNtbzv/Bi/kZYSsdA5ysaTWZfWr1M=";
  };

  nativeBuildInputs = [ pkg-config ];

  meta = with lib; {
    description = "Rofi modi for Taskwarrior";
    longDescription = ''
      A rofi wrapper for taskwarrior. Provides a rofi-script modi,
      so that you can review, start, stop, edit and mark tasks done.
    '';
    homepage = "https://crates.io/crates/rofi-taskwarrior";
    license = licenses.mpl20;
    maintainers = [ maintainers.nyarly ];
  };
}
