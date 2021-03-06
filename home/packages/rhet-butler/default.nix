{ bundlerApp, fetchFromGitHub, lib }:

bundlerApp rec {
  pname = "rhet-butler";

  gemdir = ./.;

  exes = [ "rhet-butler" ];

  meta = {
    version = "0.14.0";
    description	= "A web tech presentation system";
    longDescription	= ''
      Rhet Butler is a presentation assistant. Build a slide deck in simple YAML,
      design it in CSS, run the presentation with your smartphone over Websockets.
    '';
    homepage = https://github.com/nyarly/rhet-butler;
    license = "MIT";
    maintainers = with lib.maintainers; [ nyarly ];
    platforms = lib.platforms.all;
  };
}
