{
  lib,
  config,
  pkgs,
  unstable,
  localpkgs,
  ...
}:

let
  inherit (pkgs.callPackage home/loadConfigs.nix { }) configFiles;

  yubikeys = [
    "fd7a96"
    "574947"
  ];
in
{
  disabledModules = [
    "services/lorri.nix"
  ];

  imports = [
    home/services/nitrogen.nix
    home/services/scdaemon-notify.nix
    home/services/nm-applet.nix
    home/services/my-polybar.nix
    home/services/lorri.nix

    home/programs/scdaemon.nix
  ];

  xdg.mimeApps = import ./mimeApps.nix;

  nixpkgs.config = import ./nixpkgs-config.nix;

  home.packages = (import ./home/packages.nix) {
    inherit
      lib
      pkgs
      unstable
      localpkgs
      ;
  };

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

    claude-code = {
      enable = true;
      settings = {
        spinnerVerbs = {
          mode = "replace";
          verbs = [ "> " ];
        };
        # showTurnDuration: false; # is also "playful"
      };
    };

    eza.enable = true;
    bat = {
      enable = true;
      config = {
        wrap = "never";
        "set-terminal-title" = true;
      };
    };
    fzf.enable = true;
    gh = {
      package = unstable.gh;
      enable = true;
      extensions = with pkgs; [
        gh-notify
        gh-s
      ];
    };
    gh-dash.enable = true;
    jq.enable = true;
    fd.enable = true;

    hexchat.enable = true;
    feh.enable = true;
    rofi = {
      enable = true;
      pass = {
        enable = true;
        extraConfig = lib.readFile home/config/rofi-pass;
      };
    };

    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };

    ripgrep = {
      enable = true;
      arguments = [
        "--smart-case"
      ];
    };

    zk = (import home/zk.nix) { };
    htop = (import home/htop.nix) { inherit config; };
    ssh = (import home/ssh.nix) { inherit yubikeys; };
    git = (import home/git.nix) { inherit pkgs; };
    delta = {
      enable = true;
      options = {
        light = true;
      };
      enableGitIntegration = true;
    };
    fish = (import home/fish.nix) { inherit pkgs unstable; };
    neovim = (import home/neovim.nix) { inherit lib pkgs; };
    taskwarrior = (import home/taskwarrior.nix) { inherit unstable config; };
    tmux = (import home/tmux.nix) { inherit pkgs; };

    bottom = {
      enable = true;
      settings.styles.theme = "nord-light";
    };

    direnv = {
      enable = true;
      stdlib = builtins.readFile home/config/direnvrc;
    };

    element-desktop.enable = true;
    password-store = {
      enable = true;
      package = (
        pkgs.pass.withExtensions (
          ext: with ext; [
            pass-update
            pass-genphrase
            pass-otp
          ]
        )
      );
      settings = {
        PASSWORD_STORE_X_SELECTION = "primary";
      };

    };

  };

  services = {
    # taskwarrior-sync
    nm-applet.enable = true;
    scdaemonNotify.enable = true;
    keynav.enable = true;
    picom.enable = true;
    espanso = {
      enable = true;

      configs.default = {
        # show_notifications = false;
        toggle_key = "RIGHT_CTRL";
      };

      matches.base.matches = [
        {
          trigger = "a/o/t";
          replace = "as opposed to";
        }
        {
          trigger = "e.g.";
          replace = "for example";
        }
        {
          trigger = "i.e.";
          replace = "in other words";
        }
        {
          trigger = "n.b.";
          replace = "be aware";
        }
        {
          trigger = "cf.";
          replace = "but compare";
        }
        {
          trigger = "q.v.";
          replace = "for which see";
        }
        {
          trigger = "b/c";
          replace = "because";
        }
        {
          trigger = "d/c";
          replace = "don't care";
        }
        {
          trigger = "idk";
          replace = "I don't know";
        }
        {
          trigger = "iiuc";
          replace = "if I understand correctly";
        }
        {
          trigger = "iirc";
          replace = "if I recall correctly";
        }
        {
          trigger = "afaik";
          replace = "as far as I know";
        }
        {
          trigger = "afk";
          replace = "away from computer";
        }
        {
          trigger = "eod";
          replace = "end of day";
        }
        {
          trigger = "imo";
          replace = "in my opinion";
        }
        {
          trigger = "IMO";
          replace = "In my opinion";
        }
        {
          trigger = "lgtm";
          replace = "looks good to me";
        }
        {
          trigger = "k8s";
          replace = "Kubernetes";
        }
        {
          trigger = ":6date";
          replace = "{{6date}}";
          vars = [
            {
              name = "6date";
              type = "date";
              params = {
                format = "%y%m%d";
              };
            }
          ];
        }
        {
          trigger = ":10date";
          replace = "{{10date}}";
          vars = [
            {
              name = "10date";
              type = "date";
              params = {
                format = "%Y-%m-%d";
              };
            }
          ];
        }

      ];
    };

    dunst = import home/dunst.nix;
    gpg-agent = (import home/gpg-agent.nix) { inherit pkgs; };
    nitrogen = (import home/nitrogen.nix) { inherit config; };

    lorri = {
      package = pkgs.callPackage home/packages/lorri { };
      enable = true;
      enableNotifications = true;
    };

    myPolybar = {
      enable = true;
      package =
        with pkgs;
        polybar.override {
          pulseSupport = true;
          githubSupport = true;
          inherit curl libpulseaudio;
        };
      config = import plugins/polybarConfig.nix { inherit lib config pkgs; };
    };
  };

  home.file = {
    ".local/share/fonts/monofur/monof56.ttf".source = home/fonts/monof55.ttf;
    ".local/share/fonts/monofur/monof55.ttf".source = home/fonts/monof56.ttf;
    "Data/Wallpaper/rotsnakes-tile.png".source = home/blobs/rotsnakes-tile.png;
    ".task/keys/ca.cert".source = home/task/keys/ca.cert;
    ".ssh/control" = {
      recursive = true;
      source = home/ssh/control;
    };
  }
  // builtins.listToAttrs (
    builtins.concatMap (k: [
      {
        name = ".ssh/yubi-${k}.pub";
        value = {
          source = home/ssh + "/yubi-${k}.pub";
        };
      }
      {
        name = ".gnupg/yubi-${k}.pub";
        value = {
          source = home/gnupg + "/yubi-${k}.pub.gpg";
        };
      }
      {
        name = ".config/git/sign-with-${k}";
        value = {
          source = home/config/git + "/sign-with-${k}";
        };
      }
    ]) yubikeys
  )
  // configFiles home/bin "bin"
  // configFiles home/config/git/hooks ".git_template/hooks"
  // configFiles home/config/git/hooks ".config/git/hooks"
  // configFiles home/config/go-jira ".jira.d";

  home.activation =
    let
      mkAct = k: v: lib.hm.dag.entryAfter [ "writeBoundary" ] v;
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
    "procs/config.toml".source = home/config/procs.toml;
    "alacritty/alacritty-hm.toml".source = home/config/alacritty.toml;
    "alacritty/color-scheme-light.toml".source = home/config/alacritty-color-scheme-light.toml;
    "alacritty/color-scheme-dark.toml".source = home/config/alacritty-color-scheme-dark.toml;
    "nixpkgs/config.nix".source = ./nixpkgs-config.nix;
    "keynav/keynavrc".source = home/config/keynavrc;
    "nvim/autoload/tmuxline/presets/nyarly.vim".source = home/config/neovim/tmuxline-preset.vim;
    "nvim/swapfile_parse.rb".source = home/config/neovim/swapfile_parse.rb;
  }
  // configFiles home/config/neovim/after/ftplugin "nvim/after/ftplugin"
  // configFiles home/config/neovim/ftplugin "nvim/ftplugin"
  // configFiles home/config/hexchat "hexchat"
  // configFiles home/config/fish/completions "fish/completions"
  // configFiles home/config/fish/functions "fish/functions"
  // configFiles home/config/zk/templates "zk/templates";

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
# transitional configs
# fontconfig?
# gconf ? (nm-manager)
# mimeapps.conf ?
