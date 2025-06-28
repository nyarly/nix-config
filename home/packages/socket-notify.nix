{ lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  dbus,
  ... }:

with rustPlatform;

buildRustPackage rec {
  crateName = "socket-notify";
  version = "0.1.3";

  name = "${crateName}-${version}";

  cargoHash = "sha256-rZVZsFrHTapfrijvxxsPBXvO9g4fEBmEOrtiEtNSvgA=";

  src = fetchFromGitHub {
    owner = "nyarly";
    repo = crateName;
    rev = version;
    hash = "sha256-QlBXXK/zGxjQ6VYg/264d0Sb0yWwlpvMEA85GMOirTc=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ dbus ];

  meta = with lib; {
    description = "SCDaemon to Libnotify gateway";
    longDescription = ''
      You should receive notification like "GPG Event" whenever your
      verification of a signing or authentication operation is required. When
      you approve the signature (or it times out) the notification is replaced
      with a short-lived update.
    '';
    homepage = "https://crates.io/crates/socket-notify";
    license = licenses.mit;
    maintainers = [ maintainers.nyarly ];
  };
}
