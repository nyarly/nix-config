  let
  unstableTarball = fetchGit {
    name = "nixos-unstable-2020-07-07";
    url = https://github.com/nixos/nixpkgs-channels;
    ref = "refs/heads/nixos-unstable";
    # `git ls-remote https://github.com/nixos/nixpkgs-channels nixos-unstable`
    rev = "dc80d7bc4a244120b3d766746c41c0d9c5f81dfa";
  };
in
{
  permittedInsecurePackages = [
    "mailpile-1.0.0rc2"
  ];
  packageOverrides = pkgs: rec {
    unstable = import unstableTarball {};

    networkmanager_openconnect = pkgs.networkmanager_openconnect.override {
      openconnect = pkgs.openconnect_gnutls;
    };

    wine = pkgs.wine.override {
      xmlSupport = true;
    };
  };
  nixpkgs.config.allowUnfreePredicate = pkg: let
    pkgname = (builtins.parseDrvName pkg.name or pkg.pname).name;
  in
    pkgname == "postman";
}
