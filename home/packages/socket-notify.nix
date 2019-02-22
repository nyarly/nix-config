{ stdenv, fetchCrate, rustPlatform, ... }:

with rustPlatform;

buildRustPackage rec {
  crateName = "socket-notify";
  version = "0.1.1";
  sha256="16gl8nmj4nyv1vxfa46p7p7y7hl3ynkyp2rz2jiv199cpjmysgna";

  name = "${crateName}-${version}";

  cargoSha256 = sha256;

  src = fetchCrate { inherit crateName version sha256; };

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
