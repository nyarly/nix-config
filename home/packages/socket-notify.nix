{ lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  dbus,
  ... }:

with rustPlatform;

buildRustPackage rec {
  crateName = "socket-notify";
  version = "0.1.2";

  name = "${crateName}-${version}";

  cargoHash = "sha256-AIwfnvAz+XZGKkMR1fh02SHRPA6HExOoTOpy+O0UEI0=";

  src = fetchFromGitHub {
    owner = "nyarly";
    repo = crateName;
    rev = version;
    hash = "sha256-LZU4oYIr3/Sv0tj7j/Y69Mc45xdfnU8iQ1N5CdZPf0M=";
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
