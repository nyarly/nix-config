{ stdenv, lib, rustPlatform, fetchFromGitHub, pkgconfig, vimUtils, ... }:

with rustPlatform;

let
  crateName = "vim-markdown-composer";

  src = fetchFromGitHub {
    owner = "euclio";
    repo = crateName;
    rev = "master";
    hash = "sha256-bgJmF3RzZxbLV2Z6zvCYQIt4AdfCmkgWpWNnDbDs4MM=";
  };

  markdown-composer = buildRustPackage rec {
    version = "0.2.3";

    inherit crateName src;

    name = "${crateName}-${version}";

    cargoSha256 = "sha256-owewqavzUHSRDPHPQrIOxDBn3GejQGGER6sDNcXswCY=";

    nativeBuildInputs = [ pkgconfig ];
  };
in
vimUtils.buildVimPlugin {
  name = "vim-markdown-composer-2020-08-14";
  inherit src;
  postInstall = ''
    target=$out/$rtpPath/$path/target/release
    mkdir -p $target
    cp ${markdown-composer}/bin/markdown-composer $target
  '';
}
