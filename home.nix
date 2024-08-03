{ lib, config, pkgs, unstable, ... }:

let
  inherit (pkgs.callPackage home/loadConfigs.nix {}) transitionalConfigs configFiles;

  updated = {
    # signal = pkgs.callPackage home/packages/signal-desktop.nix {};
    # go-jira = pkgs.callPackage home/packages/go-jira.nix {};
    # meld = pkgs.callPackage home/packages/meld.nix {};
    # trivy = pkgs.callPackage home/packages/trivy.nix {}; # >= 0.20
  };
  # localPackages = {
    # lorri = pkgs.callPackage home/packages/lorri {};
    # vim-markdown-composer = pkgs.callPackage home/packages/vim-markdown-composer.nix {};
    # rhet-butler = pkgs.callPackage home/packages/rhet-butler {};
  # }

  yubikeys = [ "fd7a96" "574947" ];
in
  {
    imports = [
      home/services/nitrogen.nix
      home/services/scdaemon-notify.nix
      home/services/nm-applet.nix
      home/services/my-polybar.nix

      home/programs/scdaemon.nix
    ];

    xdg.mimeApps = import ./mimeApps.nix;

    nixpkgs.config = import ./nixpkgs-config.nix;

    home.packages = (import ./home/packages.nix) { inherit lib pkgs updated unstable; };

    gtk = {
      iconTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
      };
      theme = {
        package = pkgs.gnome3.gnome-themes-standard;
      };
    };

    programs = {
      # Let Home Manager install and manage itself.
      home-manager.enable = true;

      htop = (import home/htop.nix) {inherit config;};
      ssh = (import home/ssh.nix) {inherit yubikeys;};
      git = (import home/git.nix) {inherit pkgs;};
      fish = (import home/fish.nix) {inherit pkgs unstable;};
      neovim = (import home/neovim.nix) { inherit lib pkgs unstable;};
      taskwarrior = (import home/taskwarrior.nix) { inherit config;};

      bottom = {
        enable = true;
        settings.flags.color = "gruvbox-light";
      };

      direnv = {
        enable = true;
        stdlib = builtins.readFile home/config/direnvrc;
      };
    };

    services = {
      nm-applet.enable = true;
      scdaemonNotify.enable = true;
      keynav.enable = true;
      picom.enable = true;

      dunst = import home/dunst.nix;
      gpg-agent = (import home/gpg-agent.nix) { inherit pkgs; };
      nitrogen = (import home/nitrogen.nix) { inherit config; };

      lorri = {
        enable = true;
        enableNotifications = true;
      };

      myPolybar = {
        enable = true;
        package = with pkgs; polybar.override {
          pulseSupport = true;
          githubSupport = true;
          inherit curl libpulseaudio;
        };
        config = import plugins/polybarConfig.nix { inherit lib config pkgs; };
      };
    };

    home.file = {
      ".tmux.conf".source = home/config/tmux.conf;
      ".local/share/fonts/monofur/monof56.ttf".source = home/fonts/monof55.ttf;
      ".local/share/fonts/monofur/monof55.ttf".source = home/fonts/monof56.ttf;
      "Data/Wallpaper/rotsnakes-tile.png".source = home/blobs/rotsnakes-tile.png;
      ".task/keys/ca.cert".source = home/task/keys/ca.cert;
      ".ssh/control" = {
        recursive = true;
        source = home/ssh/control;
      };
    }
    // builtins.listToAttrs (builtins.concatMap (k: [
      {name = ".ssh/yubi-${k}.pub"; value = {source = home/ssh + "/yubi-${k}.pub" ;};}
      {name = ".gnupg/yubi-${k}.pub"; value = {source = home/gnupg + "/yubi-${k}.pub.gpg" ;};}
      {name = ".config/git/sign-with-${k}"; value = {source = home/config/git + "/sign-with-${k}" ;};}
    ]) yubikeys)
    // configFiles home/bin "bin"
    // configFiles home/config/git/hooks ".git_template/hooks"
    // configFiles home/config/git/hooks ".config/git/hooks"
    // configFiles home/config/go-jira ".jira.d";

    home.activation = let
      mkAct = k: v: lib.hm.dag.entryAfter ["writeBoundary"] v;
    in
    builtins.mapAttrs mkAct {
      chownSSH = ''
        $DRY_RUN_CMD chmod -R og= $HOME/.ssh
      '';
      chownGPG = ''
        $DRY_RUN_CMD chmod -R og= $HOME/.gnupg
      '';

      materializeAlacritty = ''
        CFG=$HOME/.config/alacritty/alacritty
        $DRY_RUN_CMD cp -f $CFG-hm.toml $CFG.toml
      '';

      setupGitGpg = ''
        $DRY_RUN_CMD cd $HOME/.config/git
        $DRY_RUN_CMD ln -s sign-with-fd7a96 secret || echo "secret already linked"
        '';
    };

    xdg.configFile = {
      "git/trimwhite.sh".source = home/config/git/trimwhite.sh;
      "rofi-pass/config".source = home/config/rofi-pass;
      "alacritty/alacritty-hm.toml".source = home/config/alacritty.toml;
      "alacritty/color-scheme-light.toml".source = home/config/alacritty-color-scheme-light.toml;
      "alacritty/color-scheme-dark.toml".source = home/config/alacritty-color-scheme-dark.toml;
      "nixpkgs/config.nix".source = ./nixpkgs-config.nix;
      "keynav/keynavrc".source = home/config/keynavrc;
    }
    // configFiles home/config/neovim/ftplugin "nvim/after/ftplugin"
    // configFiles home/config/hexchat "hexchat"
    // configFiles home/config/fish/completions "fish/completions"
    // configFiles home/config/fish/functions "fish/functions"
    // transitionalConfigs home/config/transitional;

    xsession = {
      enable = true;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        # extraPackages = hpkgs: [ ];
        config = home/config/xmonad.hs;
      };
    };
  }

# TODO

# Document whole-system setup (Doc driven dev, yo)
# git_template
# gocode
# fish functions
# fish completions
# fish dir cleanup

# xembedsniproxy.service # maybe a better choice than trayer?
#   taffybar has a whole "set up the SNItray first" thing,
#   which HM might support well.
# polybar template service files (to help with crashes)2
# transitional configs
# fontconfig?
# gconf ? (nm-manager)
# mimeapps.conf ?
