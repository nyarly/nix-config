{
  permittedInsecurePackages = [
    "mailpile-1.0.0rc2"
    "python2.7-pyjwt-1.7.1"
    "python2.7-certifi-2021.10.8"
    "nix-2.15.3"
    "vault-1.14.10"
    "keycloak-23.0.6"
  ];
  packageOverrides = pkgs: {
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
    "terraform" #BSL
    "vault" # BSL

    "cloudflared"
    "google-chrome"
    "google-chrome-beta"
    "google-chrome-dev"
  ];
}
