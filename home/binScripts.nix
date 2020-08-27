{ stdenv, pkgs, lib, makeWrapper }:
let
  fromBin = name: deps:
  stdenv.mkDerivation rec {
    inherit name;
    src = ./bin + "/${name}";
    nativeBuildInputs = [ makeWrapper ];
    buildInputs = map (d: builtins.getAttr d pkgs) deps;
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/${name}
      chmod +x $out/bin/${name}
      wrapProgram $out/bin/${name} --prefix PATH : "${lib.makeBinPath buildInputs}"
    '';
  };

  wrap = cfg: (lib.mapAttrs fromBin cfg);
in
  wrap {
    "ontask" = ["bash" "taskwarrior"];
    "task_polybar.sh" = ["bash" "taskwarrior"];
    "rofi-screenlayout" = ["bash" "rofi" "dmenu"]; # Consider using Rofi directly
    "rofi-scripts" = ["bash" "rofi" "dmenu"];     # to remove dep on dmenu
  }
