{
  stdenv,
  fetchurl,
  gnutar,
  autoPatchelfHook,
  lib,
}:

stdenv.mkDerivation rec {
  name = "acli";
  version = "1.3.4";
  # The v1.3.4 version for Linux is https://acli.atlassian.com/linux/1.3.4-stable/acli_1.3.4-stable_linux_amd64.tar.gz

  # gpg --receive-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
  # gpg --verify op.sig op
  src = fetchurl {
    url = "https://acli.atlassian.com/linux/${version}-stable/acli_${version}-stable_linux_amd64.tar.gz";
    sha256 = "sha256-5jnzsRX4sPfemdMhW+uBDSv1QjLF/hjA8Jrel16bRZM=";
  };

  nativeBuildInputs = [
    gnutar
    autoPatchelfHook
  ];

  buildInputs = [ ];

  unpackPhase = ''
    tar xvzf $src
  '';

  installPhase = ''
    install -m755 -D acli_${version}-stable_linux_amd64/acli $out/bin/acli
  '';

  meta = with lib; {
    homepage = "https://developer.atlassian.com/cloud/acli/guides/introduction/";
    description = "CLI for Atlassian/Jira";
    platforms = platforms.linux;
    maintainers = with maintainers; [ nyarly ];
  };
}
