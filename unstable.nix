let
  unstableTgz = builtins.fetchTarball {
    # Descriptive name to make the store path easier to identify
    name = "nixos-unstable-2020-09-09";
    # Be sure to update the above if you update the archive
    url = https://github.com/nixos/nixpkgs-channels/archive/e0759a49733dfc3aa225b8a7423c00da6e1ecb67.tar.gz;
    sha256 = "1lnaifrbdmvbmz25404z7xpfwaagscs1i80805fyrrs1g27h21qb";
  };
in
import unstableTgz {}
