{ stdenv, pkgs, lib, makeWrapper }:
let
  fromBin = name: buildInputs:
  stdenv.mkDerivation rec {
    inherit name;
    src = ./bin + "/${name}";
    nativeBuildInputs = [ makeWrapper ];
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/${name}
      chmod +x $out/bin/${name}
      touch $out/bin/wtf
      wrapProgram $out/bin/${name} --prefix PATH : "${lib.makeBinPath buildInputs}"
    '';
  };

  wrap = cfg: (lib.mapAttrs fromBin cfg);
in
  wrap (with pkgs; {
    "materialize-config" = [ fish ];
    "add-task-context" = [fish gnugrep];
    "end-of-day" = [fish taskwarrior3 gitFull]; # should include commute as well
    "ontask" = [bash taskwarrior3];
    "task_polybar.sh" = [bash taskwarrior3];
    "rofi-screenlayout" = [bash rofi util-linux]; # Consider using Rofi directly
    "rofi-scripts" = [bash rofi util-linux];     # to remove dep on dmenu
    "git-jira-branch" = [bash gitFull go-jira];
    "git-current-jira" = [bash gitFull go-jira];
    "current-unstable.nix" = [ bash gitFull ];
    "nix-pin-branch" = [ bash gitFull ];
    "toggle-scheme" = [fish gnugrep gnused];
    "dim-screen" = [bash xorg.xbacklight];
    "quick-jira-task" = [fish gnugrep yq-go];
    "project-contexts" = [fish];
    "created-at-commit" = [bash gitFull coreutils];
  })
