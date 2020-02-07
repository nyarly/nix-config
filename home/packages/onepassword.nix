{ stdenv
, fetchurl
, unzip
, zlib
, autoPatchelfHook
, lib
}:

stdenv.mkDerivation rec {
  name = "op";
  version = "0.9.2";

  # gpg --receive-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
  # gpg --verify op.sig op
  src = fetchurl {
    url = "https://cache.agilebits.com/dist/1P/op/pkg/v${version}/op_linux_amd64_v${version}.zip";
    sha256 = "0fvkb1ilawydbq5ws1f8ahinpb49cs2g154p2x0s37n54khhpjgh";
  };

  nativeBuildInputs = [
    unzip
    autoPatchelfHook
  ];

  buildInputs = [ ];

  unpackPhase = ''
    unzip $src
  '';

  installPhase = ''
    install -m755 -D op $out/bin/op
  '';


  meta = with stdenv.lib; {
    homepage = https://support.1password.com;
    description = "CLI for 1Password";
    platforms = platforms.linux;
    maintainers = with maintainers; [ nyarly ];
  };
}
