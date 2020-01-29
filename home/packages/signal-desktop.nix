{pkgs, fetchurl, lib, ...}:
pkgs.signal-desktop.overrideAttrs (oldAttrs: rec {
  name = "signal-desktop-${version}";
  pname = "signal-desktop";
  version = "1.30.0";
  src = fetchurl {
    url = "https://updates.signal.org/desktop/apt/pool/main/s/signal-desktop/signal-desktop_1.30.0_amd64.deb";
    sha256 = "1gbvna40sc83s7mwip5281yn4bs0k19fj061y0xzwkvh0yk06x3i"; # lib.fakeSha256;
  };
})
