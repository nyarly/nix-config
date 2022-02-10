let
  unstableTgz = builtins.fetchTarball {
    # Descriptive name to make the store path easier to identify
    name = "nixos-nixos-unstable-2022-02-02";
    # Be sure to update the above if you update the archive
    url = https://github.com/nixos/nixpkgs/archive/98bb5b77c8c6666824a4c13d23befa1e07210ef1.tar.gz;
    sha256 = "0gvf96m5m7lvsgb61k6wkqb20ykmizhyi0k3sww374i0v1r6wlmc";
  };
in
import unstableTgz {}
