#!/bin/bash

date=$(date +'%Y-%m-%m')
rev=$(git ls-remote https://github.com/nixos/nixpkgs-channels nixos-unstable | awk '{ print $1 }')
url="https://github.com/nixos/nixpkgs-channels/archive/${rev}.tar.gz"
sha=$(nix-prefetch-url --unpack $url)

cat <<NIX
let
  unstableTgz = builtins.fetchTarball {
    # Descriptive name to make the store path easier to identify
    name = "nixos-unstable-${date}";
    # Be sure to update the above if you update the archive
    url = ${url};
    sha256 = "${sha}";
  };
in
import unstableTgz {}
NIX
