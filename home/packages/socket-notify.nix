{ stdenv, rustPlatform, fetchFromGitHub, pkgconfig, dbus, ... }:

with rustPlatform;

buildRustPackage rec {
  crateName = "socket-notify";
  version = "0.1.2";

  name = "${crateName}-${version}";

  cargoSha256 = "0fhp53c2k9iph38gic5ds1zkp5989vajf3jdvn5d35a3kmpwxg4s";

  src = fetchFromGitHub {
    owner = "nyarly";
    repo = crateName;
    rev = version;
    sha256 = "0hvz9zb0jyak8ci4z7az2zkkiizl7bv8zyyqsapz9prbhahki59d";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ dbus ];

  meta = with stdenv.lib; {
    description = "SCDaemon to Libnotify gateway";
    longDescription = ''
      You should receive notification like "GPG Event" whenever your
      verification of a signing or authentication operation is required. When
      you approve the signature (or it times out) the notification is replaced
      with a short-lived update.
    '';
    homepage = https://crates.io/crates/socket-notify;
    license = licenses.mit;
    maintainers = [ maintainers.nyarly ];
  };
}
