let
  unstableTgz = builtins.fetchTarball {
    # Descriptive name to make the store path easier to identify
    name = "nixos-nixos-unstable-2021-07-07";
    # Be sure to update the above if you update the archive
    url = https://github.com/nixos/nixpkgs/archive/c6c4a3d45ab200f17805d2d86a1ff1cc7ca2b186.tar.gz;
    sha256 = "1f6q98vx3sqxcn6qp5vpy00223r9hy93w9pxq65h9gdwzy3w4qxv";
  };
in
import unstableTgz {}
