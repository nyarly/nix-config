{lib, pkgs, unstable, updated}:
let
  binScripts = lib.filterAttrs (n: v: lib.isDerivation v) (pkgs.callPackage ./binScripts.nix { pkgs = pkgs // updated; });
  rofi-taskwarrior = pkgs.callPackage packages/rofi-taskwarrior {};
  confit = pkgs.callPackage packages/confit {};
in
    with pkgs; [
      # The modern shell
      procs
      bat
      eza
      kalker
      rofi-taskwarrior
      confit

      bash
      fasd
      fzf
      hexchat
      element-desktop
      illum # should be made a service
      inetutils
      man-pages
      moreutils
      nftables
      (pass.withExtensions (ext: with ext; [
        pass-update
        pass-genphrase
        pass-otp
      ]))
      plasma-desktop #needed for xembed-sni-proxy
      ranger # in vim
      ripgrep
      tmux

      wmctrl
      xorg.xmessage

      signal-desktop
      # updated.signal

      unstable.gitAndTools.gh
      gist

      jq
      go-jira # >1.0.24
      trivy
      docker
      docker-compose
      bind # for dig

      # GUI
      dunst
      feh
      unstable.rofi
      unstable.rofi-pass

      gucharmap
      meld
      nitrogen
      shutter
      # postman
      bruno

      pandoc
      mark
      terraform-ls
      tflint

      languagetool
      proselint
      vale
    ] ++
    (builtins.attrValues binScripts)
