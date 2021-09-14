{ stdenv, lib, rustPlatform, fetchFromGitHub, pkgconfig, vimUtils, ... }:

with rustPlatform;

let
  crateName = "vim-markdown-composer";

  src = fetchFromGitHub {
    owner = "euclio";
    repo = crateName;
    rev = "master";
    hash = "sha256-9ug80pAHdQJI5p3eFLYPcD8udcsRTvrdR17q+dAda4M=";
  };

  markdown-composer = buildRustPackage rec {
    version = "0.2.3";

    inherit crateName src;

    name = "${crateName}-${version}";

    cargoSha256 = "sha256-aAnINaXmAedFAzD6+x3zQgfr1YiAcII6JH5m68kQrss=";

    nativeBuildInputs = [ pkgconfig ];

    /*
    meta = with lib; {
      description = "Makes sure your work is properly preserved";
      longDescription = ''
        A command line tool to check that git workplaces are properly
        preserved: that files are tracked, committed, tagged, and on a branch that
        tracks a remote, is pushed there.
      '';
      homepage = https://crates.io/crates/confit;
      license = licenses.mit; # before submission, need indiecc in nixpkgs
      maintainers = [ maintainers.nyarly ];
    };
    */
  };
in
vimUtils.buildVimPlugin {
  name = "vim-markdown-composer-2020-08-14";
  inherit src;
  postInstall = ''
    target=$out/$rtpPath/$path/share/vim-plugins/vim-markdown-composer/target/release
    mkdir -p $target
    cp ${markdown-composer}/bin/markdown-composer $target
  '';
}
