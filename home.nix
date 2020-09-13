{ lib, config, pkgs, ... }:

let
  vimUtils = pkgs.callPackage (<nixpkgs> + "/pkgs/misc/vim-plugins/vim-utils.nix") {};

  inherit (pkgs.callPackage home/loadConfigs.nix {}) transitionalConfigs configFiles;


  localNvimPlugins = pkgs.callPackage ./personal-nvim-plugins.nix {
    inherit (pkgs) fetchgit;
    inherit (vimUtils) buildVimPluginFrom2Nix;
  };

  myBundix = pkgs.callPackage home/packages/bundix.nix {};

  rhet-butler = pkgs.callPackage home/packages/rhet-butler {};

  updated = {
    signal = pkgs.callPackage home/packages/signal-desktop.nix {};
    go-jira = pkgs.callPackage home/packages/go-jira.nix {};
  };
  onepassword = pkgs.callPackage home/packages/onepassword.nix {};
  licensezero = pkgs.callPackage home/packages/licensezero {};

  binScripts = lib.filterAttrs (n: v: lib.isDerivation v) (pkgs.callPackage home/binScripts.nix { pkgs = pkgs // updated; });
in
  {
    imports = [
      home/services/nitrogen.nix
      # home/services/restart-taffybar.nix
      home/services/trayer.nix
      home/services/scdaemon-notify.nix
      home/services/nm-applet.nix
      home/services/lorri.nix
      home/services/my-polybar.nix

      home/programs/scdaemon.nix
    ];

    nixpkgs.config = import ./config.nix;
    nixpkgs.overlays = with builtins; (
      let
        content = readDir ./overlays;
      in
        map (n: import (./overlays + ("/" + n)))
          (
            filter
              (n: match ".*\\.nix" n != null || pathExists (./overlays + ("/" + n + "/default.nix")))
              (attrNames content)
          )
    );

    # Removed from home.packages:
    # Belongs in shell.nix:
    #  licensezero
    #  graphviz
    #  html-tidy
    #  sqlite-interactive
    #  rustChannels.stable.rust
    #  fswatch
    #  gnumake
    #  go
    #  lldb
    #  ruby
    #  universal-ctags
    #  inkscape
    #  solvespace
    #  gimp


    # Not currently using
    #  mailpile
    #  fira-code #source for monofur ideas
    #  gnugo
    #  wxcam
    #  dynamic-colors
    #
    # License issues
    #  ec2_ami_tools # unfree Amazon license
    #  ec2_api_tools
    #  adobe-reader #marked insecure


    home.packages = with pkgs; [
      # The modern shell
      unstable.procs
      bat
      exa
      fd
      sd

      bash
      fasd
      fzf
      hexchat
      hicolor-icon-theme
      illum # should be made a service
      inetutils
      manpages
      moreutils
      nftables
      (pass.withExtensions (ext: with ext; [
        pass-update
        pass-genphrase
        pass-otp
      ]))
      pinfo
      plasma-desktop #needed for xembed-sni-proxy
      ranger # in vim
      ripgrep
      tmux

      wmctrl
      xorg.xmessage

      #signal-desktop # expired in stable
      updated.signal

      # Programming
      # Need for direnv...
      go2nix
      pypi2nix
      bundix
      carnix

      gitAndTools.gh
      gitFull
      gist

      jq
      updated.go-jira

      # GUI
      dunst
      feh
      rofi
      rofi-pass
      trayer

      gucharmap
      meld
      nitrogen
      shutter
    ] ++
    (builtins.attrValues binScripts);

    programs = {
      # Let Home Manager install and manage itself.
      home-manager.enable = true;

      htop = {
        enable = true;
        cpuCountFromZero = true;
        delay = 15;
        fields = [
          "PID" "USER" "PRIORITY" "NICE"
          "M_SIZE" "M_RESIDENT" "M_SHARE"
          "STATE" "PERCENT_CPU" "PERCENT_MEM"
          "UTIME" "COMM"
        ];
        hideThreads = true;
        hideUserlandThreads = true;
        meters = {
          left = [ "AllCPUs" "Memory" "Swap" ];
          right = [ "Tasks" "LoadAverage" "Uptime" ];
        };
        shadowOtherUsers = true;
        showProgramPath = false;
        sortKey = "PERCENT_MEM";
      };

      ssh = let
        pubkeys = [
            "~/.ssh/yubi-fd7a96.pub"
            "~/.ssh/yubi-574947.pub"
          ];
      in
      {
        enable = true;
        controlMaster = "auto";
        controlPath = "~/.ssh/control/%r@%h:%p.socket";
        controlPersist = "60m";

        extraOptionOverrides = {
          IdentitiesOnly = "yes";
          IdentityFile = "~/.ssh/%h_rsa";
          UseRoaming = "no";
        };

        matchBlocks = {
          "*.amazonaws.com" = {
            user = "root";
            identityFile = "~/.ssh/lrd_rsa";
            extraOptions = {
              StrictHostKeyChecking = "no";
              UserKnownHostsFile = "/dev/null";
            };
          };

          "github.com" = {
            identityFile = pubkeys;

            extraOptions = {
              LogLevel = "QUIET";
              ControlPersist = "300";
              ServerAliveInterval = "15";
            };
          };

          "bitbucket.org" = {
            identityFile = pubkeys;

            extraOptions = {
              LogLevel = "QUIET";
              ControlPersist = "300";
            };
          };

          "*.opentable.com sc-ssh-jump-01 *.otenv.com *.ot.tools" = {
            user = "jlester";
            identityFile = pubkeys;
            identitiesOnly = true;
            extraOptions = {
              ServerAliveInterval = "15";
            };
          };
        };
      };

      git = {
        enable = true;
        package = pkgs.gitAndTools.gitFull;
        userName = "Judson Lester";
        userEmail = "nyarly@gmail.com";
        aliases = {
          ctags = "!.git/hooks/ctags";
          bundle-tags = "!.git/hooks/bundle-ctags";
          savepoint-merge = "!~/bin/git-savepoint-merge";
          savepoint-complete = "!~/bin/git-savepoint-complete";
          savepoint-reset = "!~/bin/git-savepoint-reset";
          savepoint-zap = "branch -d savepoint";
          localize-branches = "!~/bin/git-localize-branches";
          go-root = "!echo $(pwd) $GIT_PREFIX";
          pb = "!pb";
          mt = "mergetool";
          dt = "difftool -d";
        };
        signing = {
          key = "9A3F82AA";
          signByDefault = true;
        };
        ignores = [
          ".envrc"
          ".ctrlp-root"
          ".vim-role"
          ".cadre"
          ".sw?"
          "!.swf"
          "failed_specs"
          "rspec_status"
          "*Session.vim"
          "errors.err"
          ".nix-gc/"
          ".taskrc"
        ];
        includes = [
          # condition = ? # something about "if it exists"?
          { path = "~/.config/git/secret"; }
        ];
        # can be attrs converted...
        extraConfig = {
          core = {
            fsyncobjectfiles = false;
            hooksPath = "~/.config/git/hooks";
          };
          branch.autosetupmerge = true;
          color = {
            branch = true;
            diff = true;
            grep = true;
            interactive = true;
            status = true;
            ui = true;
          };
          rerere.enabled = true;
          init.templatedir = "~/.git_template";
          bash.showDirtyState = true;
          tag.forceSignAnnotated = true;
          push = {
            default = "current";
            followTags = true;
          };
          help.autocorrect = -1;
          interactive.singlekey = true;
          merge = {
            tool = "meld";
            conflictstyle = "diff3";
          };
          mergetool = {
            keepBackup = false;
            prompt = false;
          };
          rebase.autosquash = true;

          diff = {
            tool = "meld";
            rename = "copy";
            algorithm = "patience";
          };

          url = {
            "ssh://git@github.com" = {
              insteadOf = "https://github.com";
            };
          };

          diff.rawtext.textconv = "~/.config/git/trimwhite.sh";

          filter.trimwhite.clean = "~/.config/git/trimwhite.sh";

          mergetool.mymeld.cmd = "meld --diff $LOCAL $BASE $REMOTE --output=$MERGED --diff $BASE $LOCAL --diff $BASE $REMOTE";

          # jira = { }; go-jira has its own config

          github.user = "nyarly";
        };
      };

      direnv = {
        enable = true;
        stdlib = builtins.readFile home/config/direnvrc;
      };

      # XXX Add chruby support (chruby module)
      fish = with builtins; let
        configs        = path: concatStringsSep "\n" (map (p: readFile (path + "/${p}")) (configScripts path));
        configScripts  = path: filterDir (configMatch "fish") (readDir path);
        filterDir      = f: ds: filter (n: f n ds.${n}) (attrNames ds);
        configMatch    = ext: path: type: let
          extPattern = ".*[.]${ext}$";
          isDir = type != "directory";
          isExt = match extPattern path != null;
        in
        isDir && isExt;
      in
      {
        enable = true;

        package = (pkgs.fish.overrideAttrs (oldAttrs: { cmakeFlags = []; }));

        shellInit = ''
          ulimit -n 4096
          function fish_greeting; end
          __refresh_gpg_agent_info
          set -g __fish_git_prompt_show_informative_status yes
          set -gx EDITOR ~/.nix-profile/bin/nvim
          set -gx PAGER "bat"
          set -gx MANPAGER "bat --style=plain"
          set -gx MANPATH "" $MANPATH /run/current-system/sw/share/man
          set -gx RIPGREP_CONFIG_PATH ~/.config/ripgreprc
          set -gx PASSWORD_STORE_X_SELECTION primary
          set -gx PATH /home/judson/bin $PATH
        '';
        loginShellInit = configs home/config/fish/login ;
        interactiveShellInit = ''
          stty start undef
          stty stop undef
          stty -ixon
          set -x fish_color_search_match  'normal' '--background=878787'
          set -x GIT_SSH ssh # Otherwise Go overrides ControlMaster
          bind \e\; 'commandline -r -t (commandline -t | sed \"s/:\(\d*\)/ +\1/\")'
        '' + "\n" + configs home/config/fish/interactive ;

        plugins = import home/config/fish-plugins.nix { inherit (pkgs) fetchFromGitHub; };
      };

      neovim = {
        enable = true;
        extraConfig = (import home/config/neovim/manifest.nix) lib;

        plugins = with pkgs.vimPlugins; with localNvimPlugins; [
          ale
          Colorizer
          deoplete-go
          deoplete-nvim
          direnv-vim
          Dockerfile-vim
          echodoc
          errormarker-vim
          fzf-vim
          fzfWrapper
          gist-vim
          gnupg
          godoctor-vim
          gundo
          html5-vim
          IndentAnything
          indentLine # indent markers
          jobmake
          jq-vim
          lldb-nvim
          nginx-vim
          rainbow
          ranger-vim
          rfc-syntax
          rust-vim
          semweb-vim
          sideways-vim
          sparkup
          tabular
          tagbar
          textile-vim
          tla-vim
          tmuxline-vim
          typescript-vim
          ultisnips
          vim-abolish
          #vim-actionscript
          vim-airline
          vim-airline-themes
          vim-closetag
          #vim-coffee-script
          # vim-delve
          vim-endwise
          vim-fish
          vim-fugitive
          vim-go
          #vim-indent-guides
          vim-javascript
          vim-jsx
          vim-legend
          vim-markdown
          vim-nix
          vim-obsession
          vim-puppet
          vim-ragtag
          vim-repeat
          vim-scala
          vim-sensible
          vim-surround
          vim-unimpaired
          webapi-vim
        ];
        # deoplete-rust # ALE?
        # floobits-neovim # I think it needs it's Python lib...
        # LanguageClient-neovim # ALE is all-in-one
      };

        taskwarrior = {
          enable = true;
          colorTheme = "solarized-light-256";
          config = {
            confirmation= false;
            taskd = {
              server = "tasks.madhelm.net:53589";
              certificate = "${config.home.homeDirectory}/.task/keys/public.cert";
              key = "${config.home.homeDirectory}/.task/keys/private.key";
              ca = "${config.home.homeDirectory}/.task/keys/ca.cert";
              credentials = "madhelm/judson/8dc2777a-85db-410e-8f36-889d64a8cca7";
            };
          };

          extraConfig = builtins.readFile home/config/taskrc-contexts;
        };
      };

      services = {
        nm-applet.enable = true;

        scdaemonNotify.enable = true;

        jdl-lorri.enable = true;

        keynav.enable = true;

        dunst = {
          enable = true;
          settings = {
            global = {
              font = "DejaVu Sans Book 10";
              markup = "full";
              format = ''<b>%s</b>\n%b'';
              sort = "yes";
              indicate_hidden = "yes";
              alignment = "left";
              bounce_freq = 0;
              show_age_threshold = 60;
              word_wrap = "yes";
              ignore_newline = "no";
              geometry = "300x5-4+24";
              shrink = "yes";
              transparency = 0;
              idle_threshold = 120;
              monitor = 0;
              follow = "keyboard";
              sticky_history = "yes";
              history_length = 20;
              show_indicators = "yes";
              line_height = 4;
              separator_height = 2;
              padding = 8;
              horizontal_padding = 8;
              frame_width = 3;
              frame_color = "#aaaaaa";
              separator_color = "frame";
              startup_notification = false;
              dmenu = "/run/current-system/sw/bin/dmenu -p dunst:";
              browser = "/run/current-system/sw/bin/chromium";
              icon_position = "right";
              max_icon_size = 48;
            };
            shortcuts = {
              close = "ctrl+space";
              close_all = "ctrl+shift+space";
              history = "ctrl+grave";
              context = "ctrl+shift+period";
            };
            urgency_low = {
              background = "#222222";
              foreground = "#888888";
              timeout = 10;
            };
            urgency_normal = {
              background = "#285577";
              foreground = "#ffffff";
              timeout = 10;
            };
            urgency_critical = {
              background = "#900000";
              foreground = "#ffffff";
              timeout = 0;
            };
          };
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

        gpg-agent = {
          enable = true;
          defaultCacheTtlSsh = 28800;
          defaultCacheTtl = 28800;
          maxCacheTtl = 86400;
          maxCacheTtlSsh = 86400;
          enableSshSupport = true;
          extraConfig = ''
            write-env-file ${config.home.homeDirectory}/.gpg-agent-info
          '';
        };

        nitrogen = {
          enable = true;
          extraConfig = ''
            [geometry]
            posx=1920
            posy=960
            sizex=538
            sizey=958

            [nitrogen]
            view=icon
            recurse=true
            sort=alpha
            icon_caps=false
            dirs=${config.home.homeDirectory}/Data/Wallpaper;
          '';
        };
      };

      home.file = {
        ".tmux.conf".source = home/config/tmux.conf;
        ".local/share/fonts/monofur/monof56.ttf".source = home/fonts/monof55.ttf;
        ".local/share/fonts/monofur/monof55.ttf".source = home/fonts/monof56.ttf;
        ".ssh/yubi-fd7a96.pub".source = home/ssh/yubi-fd7a96.pub;
        ".ssh/yubi-574947.pub".source = home/ssh/yubi-574947.pub;
        ".gnupg/yubi-fd7a96.pub".source = home/gnupg/yubi-fd7a96.pub.gpg;
        ".gnupg/yubi-574947.pub".source = home/gnupg/yubi-574947.pub.gpg;
        "Data/Wallpaper/rotsnakes-tile.png".source = home/blobs/rotsnakes-tile.png;
        ".task/keys/ca.cert".source = home/task/keys/ca.cert;
        ".ssh/control" = {
          recursive = true;
          source = home/ssh/control;
        };
      }
      // configFiles home/bin "bin"
      // configFiles home/config/git/hooks ".git_template/hooks"
      // configFiles home/config/git/hooks ".config/git/hooks"
      // configFiles home/config/go-jira ".jira.d";

      home.activation = {
        chownSSH = lib.hm.dag.entryAfter ["writeBoundary"] ''
          $DRY_RUN_CMD chmod -R og= $HOME/.ssh
        '';
        chownGPG = lib.hm.dag.entryAfter ["writeBoundary"] ''
          $DRY_RUN_CMD chmod -R og= $HOME/.gnupg
        '';
      };


      xdg.configFile = {
        "git/trimwhite.sh".source = home/config/git/trimwhite.sh;
        "rofi-pass/config" = {
          source = home/config/rofi-pass;
        };
      }
      // configFiles home/config/hexchat "hexchat"
      // transitionalConfigs home/config/transitional;

      xsession = {
        enable = true;
        windowManager.xmonad = {
          enable = true;
          enableContribAndExtras = true;
          extraPackages = pkgs: [
            # pkgs.taffybar
          ];
          config = home/config/xmonad.hs;
        };
      };


  # TODO

  # Document whole-system setup (Doc driven dev, yo)
  # git_template
  # gocode
  # fish functions
  # fish completions
  # fish dir cleanup
  # patchShebangs on ~/bin/

  # xembedsniproxy.service # maybe a better choice than trayer?
  #   taffybar has a whole "set up the SNItray first" thing,
  #   which HM might support well.
  # polybar template service files (to help with crashes)
  # transitional configs
  # fontconfig?
  # gconf ? (nm-manager)
  # mimeapps.conf ?
}
