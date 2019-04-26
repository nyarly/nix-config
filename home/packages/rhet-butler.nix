{ buildRubyGem, fetchFromGitHub, lib }:

buildRubyGem rec {
  name = "${gemName}-${version}";
  gemName = "rhet-butler";
  version = "edge";

  src = fetchFromGitHub {
    owner = "nyarly";
    repo = "rhet-butler";
    rev = "master";
    sha256 = "12sjp8qhlmd25yhx6p6g06arlrb7i1iip5vw8rhmyvxv2a2dcnad";
  };

  meta = {
    inherit version;
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
