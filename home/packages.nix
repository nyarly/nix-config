{
  lib,
  pkgs,
  unstable,
  localpkgs,
}:
let
  binScripts = lib.filterAttrs (n: v: lib.isDerivation v) (
    pkgs.callPackage ./binScripts.nix { pkgs = pkgs // localpkgs; }
  );
in
with pkgs;
[
  # The modern shell
  procs
  kalker
  biff
  localpkgs.wrkflw
  localpkgs.rofi-taskwarrior
  localpkgs.confit
  localpkgs.acli

  fasd
  illum # should be made a service
  inetutils
  man-pages
  moreutils
  rdap # replaces whois
  nftables
  wmctrl
  xorg.xmessage
  playerctl

  signal-desktop
  # localpkgs.signal

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
