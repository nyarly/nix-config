{
  lib,
  pkgs,
  unstable,
  updated,
  localpkgs,
}:
let
  binScripts = lib.filterAttrs (n: v: lib.isDerivation v) (
    pkgs.callPackage ./binScripts.nix { pkgs = pkgs // updated; }
  );
  rofi-taskwarrior = pkgs.callPackage packages/rofi-taskwarrior { };
  confit = pkgs.callPackage packages/confit { };
in
with pkgs;
[
  # The modern shell
  procs
  kalker
  rofi-taskwarrior
  confit
  biff
  localpkgs.wrkflw

  fasd
  illum # should be made a service
  inetutils
  man-pages
  moreutils
  rdap # replaces whois
  nftables
  wmctrl
  xorg.xmessage

  signal-desktop
  # updated.signal

  gist
  codeowners

  go-jira # >1.0.24
  trivy
  docker
  docker-compose
  bind # for dig

  gucharmap
  meld
  nitrogen
  shutter
  cachix
  nix-update

  # bruno # -> devShells
  # pandoc -> devShells/neovim
  # mark -> devShells

]
++ (builtins.attrValues binScripts)
