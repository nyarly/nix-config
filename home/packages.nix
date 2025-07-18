{lib, pkgs, unstable, updated}:
let
  binScripts = lib.filterAttrs (n: v: lib.isDerivation v) (pkgs.callPackage ./binScripts.nix { pkgs = pkgs // updated; });
  rofi-taskwarrior = pkgs.callPackage packages/rofi-taskwarrior {};
  confit = pkgs.callPackage packages/confit {};
in
  with pkgs; [
    # The modern shell
    procs
    kalker
    rofi-taskwarrior
    confit

    fasd
    element-desktop
    illum # should be made a service
    inetutils
    man-pages
    moreutils
    rdap
    nftables
    (pass.withExtensions (ext: with ext; [
      pass-update
      pass-genphrase
      pass-otp
    ]))

    wmctrl
    xorg.xmessage

    signal-desktop
    # updated.signal

    gist

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

    # jq -> programs
    # tmux -> programs
    # bash -> programs
    # bat -> programs
    # eza -> programs
    # fzf -> programs
    # hexchat -> programs
    # ripgrep -> programs
    # unstable.gitAndTools.gh -> programs

    # GUI
    # dunst -> services
    # feh -> programs
    # unstable.rofi -> programs
    # unstable.rofi-pass -> programs

    # bruno # -> devShells
    # pandoc -> devShells/neovim
    # mark -> devShells

  ] ++
(builtins.attrValues binScripts)
