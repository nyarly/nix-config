{pkgs, fetchurl, ...}:
pkgs.signal-desktop.overrideAttrs (oldAttrs: rec {
  name = "signal-desktop-${version}";
  pname = "signal-desktop";
  version = "1.29.3";
  src = fetchurl {
    url = "https://updates.signal.org/desktop/apt/pool/main/s/signal-desktop/signal-desktop_1.29.3_amd64.deb";
    sha256 = "1rkj6rwmwwvyd5041r96j1dxlfbmc6xsdrza43c0ykdrhfj73h11";
  };
})
