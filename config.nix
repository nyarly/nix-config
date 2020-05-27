{
  allowUnfree = true;
  permittedInsecurePackages = [
    "mailpile-1.0.0rc2"
  ];
  packageOverrides = pkgs: rec {
    networkmanager_openconnect = pkgs.networkmanager_openconnect.override {
      openconnect = pkgs.openconnect_gnutls;
    };

    wine = pkgs.wine.override {
      xmlSupport = true;
    };
  };
}
