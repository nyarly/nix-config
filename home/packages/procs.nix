{pkgs, fetchurl, lib, ...}:
pkgs.procs.overrideAttrs (oldAttrs: rec {
  name = "signal-desktop-${version}";
  pname = "signal-desktop";
  version = "1.34.2";
  src = fetchurl {
    url = "https://updates.signal.org/desktop/apt/pool/main/s/signal-desktop/signal-desktop_${version}_amd64.deb";
    sha256 = "0l0i6v6n6iyq1zb2rlgfjnsk37kzjqgglk824vl5kp8qbq0li6b6";
  };
})
