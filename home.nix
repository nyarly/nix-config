{ lib, config, pkgs, unstable, ... }:

let
  # vimUtils = pkgs.vimUtils.override {hasLuaModule = true;};
  vimUtils = pkgs.vimUtils;

  inherit (pkgs.callPackage home/loadConfigs.nix {}) transitionalConfigs configFiles;

  localNvimPlugins = pkgs.callPackage ./personal-nvim-plugins.nix {
    inherit (pkgs) fetchgit;
    inherit (vimUtils) buildVimPlugin;
  };

  rhet-butler = pkgs.callPackage home/packages/rhet-butler {};

  updated = {
    # signal = pkgs.callPackage home/packages/signal-desktop.nix {};
    # go-jira = pkgs.callPackage home/packages/go-jira.nix {};
    # meld = pkgs.callPackage home/packages/meld.nix {};
    # trivy = pkgs.callPackage home/packages/trivy.nix {}; # >= 0.20
  };
  onepassword = pkgs.callPackage home/packages/onepassword.nix {};
  licensezero = pkgs.callPackage home/packages/licensezero {};
  rofi-taskwarrior = pkgs.callPackage home/packages/rofi-taskwarrior {};
  confit = pkgs.callPackage home/packages/confit {};
  jdl-lorri-pkg = pkgs.callPackage home/packages/lorri {};
  #jdl-vim-markdown-composer = pkgs.callPackage home/packages/vim-markdown-composer.nix {};

  binScripts = lib.filterAttrs (n: v: lib.isDerivation v) (pkgs.callPackage home/binScripts.nix { pkgs = pkgs // updated; });

  vim-nixhash = unstable.vimPlugins.vim-nixhash;

  yubikeys = [ "fd7a96" "574947" ];
in
  {
    imports = [
      home/services/nitrogen.nix
      # home/services/restart-taffybar.nix
      home/services/scdaemon-notify.nix
      home/services/nm-applet.nix
      home/services/lorri.nix
      home/services/my-polybar.nix

      home/programs/scdaemon.nix
    ];

    nixpkgs.config = import ./nixpkgs-config.nix;

    gtk = {
      iconTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
      };
      theme = {
        package = pkgs.gnome3.gnome-themes-standard;
      };
    };


    home.packages = with pkgs; [
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
      # cinny-desktop
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
    (builtins.attrValues binScripts);



    programs = {
      # Let Home Manager install and manage itself.
      home-manager.enable = true;

      bottom = {
        enable = true;
        settings.flags.color = "gruvbox-light";
      };

      htop = {
        enable = true;
        settings = with config.lib.htop.fields;{
          ccount_guest_in_cpu_meter=0;
          color_scheme=0;
          delay=15;
          detailed_cpu_time=0;
          cpu_count_from_zero = false;
          fields =  [
            PID USER PRIORITY NICE
            M_SIZE M_RESIDENT M_SHARE
            STATE PERCENT_CPU PERCENT_MEM
            UTIME COMM
          ];
          hide_threads = true;
          hide_userland_threads = true;
          shadow_other_users = false;
          show_program_path = false;
          sort_key = PERCENT_MEM;
        } // (with config.lib.htop; leftMeters [
          (bar "AllCPUs2")
          (bar "Memory")
          (bar "Swap")
          (text "Zram")
        ]) // (with config.lib.htop; rightMeters [
          (text "Tasks")
          (text "LoadAverage")
          (text "Uptime")
          (text "Systemd")
        ]);

      };

      ssh = let
        pubkeys = map (s: "~/.ssh/yubi-${s}.pub") yubikeys;
      in
      {
        enable = true;

        controlMaster = "auto";
        controlPath = "~/.ssh/control/%r@%h:%p.socket";
        controlPersist = "60m";

        extraOptionOverrides = {
          IdentitiesOnly = "yes";
          IdentityFile = "~/.ssh/%h_rsa";
        };

        matchBlocks = {

          "github.com" = {
            identityFile = pubkeys;

            extraOptions = {
              LogLevel = "QUIET";
              ControlPersist = "300";
              ServerAliveInterval = "15";
              ServerAliveCountMax = "240";
            };
          };

          "bitbucket.org" = {
            identityFile = pubkeys;

            extraOptions = {
              LogLevel = "QUIET";
              ControlPersist = "300";
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
          key = null;
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

        delta = {
          enable = true;
          options = {
            light = true;
          };
        };

        includes = [
          # condition = ? # something about "if it exists"?
          { path = "~/.config/git/secret"; }
        ];
        # can be attrs converted...
        extraConfig = {
          core = {
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
          init = {
            templatedir = "~/.git_template";
            defaultBranch = "main";
          };
          bash.showDirtyState = true;
          tag.forceSignAnnotated = true;
          pull = {
            rebase = false;
          };
          push = {
            default = "current";
            followTags = true;
          };
          help.autocorrect = -1;
          interactive.singlekey = true;
          merge = {
            tool = "meld";
            conflictstyle = "diff3";
            renormalize = true;
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

          github.user = "nyarly";
        };
      };

      direnv = {
        enable = true;
        stdlib = builtins.readFile home/config/direnvrc;
      };

      fish = with builtins; let
        configs        = path: concatStringsSep "\n" (map (p: includeFile (path + "/${p}")) (configScripts path));
        includeFile = path: "# start: ${path}\n${readFile path}\n# end: ${path}";
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

        package = (unstable.fish.overrideAttrs (oldAttrs: { cmakeFlags = []; }));

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
          set -x BROWSER google-chrome-stable
          bind \e\; 'commandline -r -t (commandline -t | sed \"s/:\(\d*\)/ +\1/\")'
          direnv export fish | source
        '' + "\n" + configs home/config/fish/interactive ;

        plugins = import home/config/fish-plugins.nix { inherit (pkgs) fetchFromGitHub; };
      };

      neovim = {
        enable = true;
        package = unstable.neovim-unwrapped;
        extraConfig = (import home/config/neovim/manifest.nix) lib;
        #withNodeJs = true; # defaults false

        extraPackages = with pkgs; [
          gopls
          nil
          impl
          go_1_21
        ];

        plugins =
        let
          dotVim = name: {
            plugin = if pkgs.vimPlugins ? ${name} then pkgs.vimPlugins.${name} else localNvimPlugins.${name};
            config = builtins.readFile (./home/config/neovim/plugin-config + "/${name}.vim");
          };
          dotLua = name: {
            plugin = pkgs.vimPlugins.${name};
            type = "lua";
            config = builtins.readFile (./home/config/neovim/plugin-config + "/${name}.lua");
          };
        in
        with pkgs.vimPlugins; with localNvimPlugins; [
          { plugin = NeoSolarized; config = ''colorscheme NeoSolarized''; }
          {
            plugin = nvim-treesitter.withAllGrammars;
            type = "lua";
            config = builtins.readFile ./home/config/neovim/plugin-config/nvim-treesitter.lua;
          }
          nvim-treesitter-textobjects
          nvim-treesitter-context
          (dotVim "ale")
          Colorizer
          (dotLua "fidget-nvim")
          nvim-lspconfig
          rust-tools-nvim
          (dotLua "cmp-nvim-lsp")
          (dotLua "luasnip")
          friendly-snippets
          cmp_luasnip
          cmp-buffer
          cmp-path
          cmp-cmdline
          cmp-treesitter
          (dotLua "nvim-cmp")
          direnv-vim
          Dockerfile-vim
          echodoc
          errormarker-vim
          (dotVim "fzf-vim")
          fzfWrapper
          vim-gist
          (dotVim "gnupg")
          godoctor-vim
          vim-mundo
          html5-vim
          IndentAnything
          (dotVim "indentLine") # indent markers
          (dotVim "jobmake")
          jq-vim
          lldb-nvim
          nginx-vim
          (dotVim "rainbow")
          (dotVim "ranger-vim")
          rfc-syntax
          semweb-vim
          sparkup
          tabular
          (dotVim "tagbar")
          textile-vim
          tla-vim
          (dotVim "tmuxline-vim")
          typescript-vim
          ultisnips
          vim-abolish
          (dotVim "vim-airline")
          vim-airline-themes
          vim-closetag
          vim-cue
          vim-endwise
          vim-fish
          vim-fugitive
          vim-go
          vim-javascript
          vim-jsx
          vim-jsx-typescript
          (dotVim "vim-legend")
          #(dotVim "vim-markdown")
          markdown-preview-nvim #; config = "let g:mkdp_auto_start = 1"; }
          vim-nix
          vim-nixhash
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
      #xsettingsd.enable = true;

      nm-applet.enable = true;

      scdaemonNotify.enable = true;

      jdl-lorri = {
        enable = true;
        enableNotifications = true;
        nixPackage = pkgs.nixUnstable;
        package = jdl-lorri-pkg;
      };

      keynav.enable = true;

      picom.enable = true;

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
        $DRY_RUN_CMD cp -f $CFG-hm.yml $CFG.yml
      '';

      setupGitGpg = ''
        $DRY_RUN_CMD cd $HOME/.config/git
        $DRY_RUN_CMD ln -s sign-with-fd7a96 secret || echo "secret already linked"
        '';
    };


  xdg.mimeApps = let
    giveItToChrome = types: builtins.listToAttrs (map (type: {name = type; value = "google-chrome.desktop";}) types);
  in
  {
      enable = true;
      defaultApplications = giveItToChrome [
        "text/html"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/about"
        "x-scheme-handler/unknown"
        "x-scheme-handler/mailto"
        "x-scheme-handler/webcal"
        "x-scheme-handler/sgnl"
        "x-scheme-handler/chrome"
        "application/x-extension-htm"
        "application/x-extension-html"
        "application/x-extension-shtml"
        "application/xhtml+xml"
        "application/x-extension-xhtml"
        "application/x-extension-xht"
      ] // {
        # "x-scheme-handler/postman"=["Postman.desktop"];
        "x-scheme-handler/discord-402572971681644545"=["discord-402572971681644545.desktop"];
      };

      associations.added = giveItToChrome [
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/chrome"
        "text/html"
        "application/x-extension-htm"
        "application/x-extension-html"
        "application/x-extension-shtml"
        "application/xhtml+xml"
        "application/x-extension-xhtml"
        "application/x-extension-xht"
      ];
    };

    xdg.configFile = {
      "git/trimwhite.sh".source = home/config/git/trimwhite.sh;
      "rofi-pass/config".source = home/config/rofi-pass;
      "alacritty/alacritty-hm.yml".source = home/config/alacritty.yml;
      "nixpkgs/config.nix".source = ./nixpkgs-config.nix;
      "keynav/keynavrc".source = home/config/keynavrc;
    }
    // configFiles home/config/neovim/ftplugin "nvim/after/ftplugin"
    // configFiles home/config/hexchat "hexchat"
    // configFiles home/config/fish/completions "fish/completions"
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
