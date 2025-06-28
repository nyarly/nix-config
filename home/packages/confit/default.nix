{ lib, rustPlatform, fetchFromGitHub, pkg-config, ... }:

with rustPlatform;

buildRustPackage rec {
  crateName = "confit";
  version = "main";

  name = "${crateName}-${version}";

  cargoHash = "sha256-lWLiEItsvcZ9zCdCkrRYWnQdI23hb/ZoBlGGoYgPqas=";

  src = fetchFromGitHub {
    owner = "nyarly";
    repo = crateName;
    rev = version;
    hash = "sha256-l7TipT7Ou5N/pMlnnqE44i2d2XcWfPZuDEKObrqAUL8=";
  };

  nativeBuildInputs = [ pkg-config ];

  meta = with lib; {
    description = "Makes sure your work is properly preserved";
    longDescription = ''
      A command line tool to check that git workplaces are properly
      preserved: that files are tracked, committed, tagged, and on a branch that
      tracks a remote, is pushed there.
    '';
    homepage = "https://crates.io/crates/confit";
    license = licenses.mpl20; # before submission, need indiecc in nixpkgs
    maintainers = [ maintainers.nyarly ];
  };
}
