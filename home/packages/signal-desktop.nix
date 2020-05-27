{pkgs, fetchurl, lib, ...}:
pkgs.signal-desktop.overrideAttrs (oldAttrs: rec {
  name = "signal-desktop-${version}";
  pname = "signal-desktop";
  version = "1.33.2";
  src = fetchurl {
    url = "https://updates.signal.org/desktop/apt/pool/main/s/signal-desktop/signal-desktop_${version}_amd64.deb";
    sha256 = "02h2pvzcx9vb6chrdld37mmmm9vlnkck4rgwx05ii6zz652ibb9r";
    #sha256 = lib.fakeSha256;
  };
})
