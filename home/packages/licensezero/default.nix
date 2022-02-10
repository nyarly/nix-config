{ lib, stdenv, callPackage, buildGoModule, fetchFromGitHub, nodejs, git }:

let
  js = (callPackage ./npm.nix {});
in
  buildGoModule rec {
    pname = "licensezero";
    version = "7.0.3";

    modSha256 = "0p1f1jl335xxhk2jw1xy0lva113vrvr3vivi4qkhjv2h73vp6aic";

    src = fetchFromGitHub {
      owner = "licensezero";
      repo = "cli";
      rev = "v${version}";
      sha256 = "1ga1zchhi312fswj6j24ali8x5j1b8vc29cxwz25hnpjz2yx0251";
    };

    buildInputs = [ js.package nodejs git ];

    buildPhase = ''
      cp -a ${js.package}/lib/node_modules/licensezerojs/node_modules node_modules
      patchShebangs generate-jurisdictions
      make licensezero
    '';

    preInstall = ''
      mv $GOPATH/bin/cli $GOPATH/bin/licensezero
    '';

    meta = with lib; {
      description = "Simple command line client for Atlassian's Jira service written in Go";
      homepage = "https://github.com/go-jira/jira";
      license = licenses.asl20;
      maintainers = [ maintainers.carlosdagos ];
    };
  }
