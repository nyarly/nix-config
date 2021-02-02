{pkgs, fetchurl, lib, ...}:
pkgs.signal-desktop.overrideAttrs (oldAttrs: rec {
  name = "signal-desktop-${version}";
  pname = "signal-desktop";
  # Check https://github.com/signalapp/Signal-Desktop/releases
  version = "1.39.6";
  src = fetchurl {
    url = "https://updates.signal.org/desktop/apt/pool/main/s/signal-desktop/signal-desktop_${version}_amd64.deb";
    sha256 = "04fd81vc0dxk0b47crm5zacf4x79pdn483xicygnc1z6v7mnrmgk";
  };
})
