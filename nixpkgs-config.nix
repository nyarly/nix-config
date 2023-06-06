{
  permittedInsecurePackages = [
    "mailpile-1.0.0rc2"
    "python2.7-pyjwt-1.7.1"
    "python2.7-certifi-2021.10.8"
  ];
  packageOverrides = pkgs: rec {
    networkmanager_openconnect = pkgs.networkmanager_openconnect.override {
      openconnect = pkgs.openconnect_gnutls;
    };

    wine = pkgs.wine.override {
      xmlSupport = true;
    };
  };

  allowUnfreePredicate = pkg: let
    pkgname = (builtins.parseDrvName pkg.name or pkg.pname).name;
  in
  builtins.elem pkgname [
    "postman"
    "cockroach"

    "cloudflared"
  ];
}
