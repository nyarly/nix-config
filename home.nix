{ lib, config, pkgs, ... }:

let
  vimUtils = pkgs.callPackage (<nixpkgs> + "/pkgs/misc/vim-plugins/vim-utils.nix") {};

  loadConfigs = pkgs.callPackage ./home/loadConfigs.nix {};

  localNvimPlugins = pkgs.callPackage ./personal-nvim-plugins.nix {
    inherit (pkgs) fetchgit;
    inherit (vimUtils) buildVimPluginFrom2Nix;
  };

  myBundix = pkgs.callPackage ./home/packages/bundix.nix {};

  rhet-butler = pkgs.callPackage ./home/packages/rhet-butler {};
in
  {
    imports = [
      home/fisher.nix

      home/services/nitrogen.nix
      home/services/restart-taffybar.nix
      home/services/trayer.nix
      home/services/scdaemon-notify.nix
      home/services/nm-applet.nix
      home/services/lorri.nix

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

    home.packages = with pkgs; [
      pv
      exa
      hexchat
      indent
      wmctrl
      xmlstarlet
      wxcam
      bundix
      plasma-desktop #needed for xembed-sni-proxy
      hicolor-icon-theme
      tlaplusToolbox
      rhet-butler
      signal-desktop
      vit
    ];

    programs = {
      # Let Home Manager install and manage itself.
      home-manager = {
        enable = true;
      };

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

      ssh = {
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
            identityFile = "~/.ssh/yubi-fd7a96.pub";

            extraOptions = {
              LogLevel = "QUIET";
              ControlPersist = "300";
              ServerAliveInterval = "15";
            };
          };

          "bitbucket.org" = {
            identityFile = "~/.ssh/monotone_something";

            extraOptions = {
              LogLevel = "QUIET";
              ControlPersist = "300";
            };
          };

          "*.opentable.com sc-ssh-jump-01 *.otenv.com *.ot.tools" = {
            user = "jlester";
            identityFile = "~/.ssh/yubi-fd7a96.pub";
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
        userName = "Judson";
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
        ignores = [ ".envrc" ".ctrlp-root" ".vim-role" ".cadre" ".sw?" "!.swf"
        "failed_specs" "rspec_status" "*Session.vim" "errors.err" ".nix-gc/" ];
        includes = [
        {
        path = "~/.config/git/secret";
          # condition = ? # something about "if it exists"?
          }
        ];
        # can be attrs converted...
        extraConfig = ''
          [core]
          fsyncobjectfiles = false
          [branch]
          autosetupmerge = true
          [color]
          branch = true
          diff = true
          grep = true
          interactive = true
          status = true
          ui = true
          [rerere]
          enabled = true
          [init]
          templatedir = ~/.git_template

          [bash]
          showDirtyState = true

          [tag]
          forceSignAnnotated = true

          [push]
          default = current
          followTags = true

          [diff "rawtext"]
          textconv =    "~/.config/git/trimwhite.sh"

          [filter "trimwhite"]
          clean =    "~/.config/git/trimwhite.sh"
          [help]
          autocorrect = -1

          [interactive]
          singlekey = true

          [merge]
          tool = meld
          conflictstyle = diff3

          [mergetool "mymeld"]
          cmd = meld --diff $LOCAL $BASE $REMOTE --output=$MERGED --diff $BASE $LOCAL --diff $BASE $REMOTE

          [mergetool]
          keepBackup = false
          prompt = false

          [rebase]
          autosquash = yes
          [diff]
          tool = meld
          rename = copy
          algorithm = patience
          [url "git@github.com:"]
          insteadOf = https://github.com/

          [jira]
          user = jlester@opentable.com
          server = https://opentable.atlassian.net
          # password should be in ./secret
          [github]
          user = nyarly
        '';
      };

      direnv = {
        enable = true;
        stdlib = builtins.readFile ./home/config/direnvrc;
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
        shellInit = ''
          ulimit -n 4096
          function fish_greeting; end
          __refresh_gpg_agent_info
          set -g __fish_git_prompt_show_informative_status yes
          set -gx EDITOR ~/.nix-profile/bin/nvim
          set -gx PAGER "less -RF"
          set -gx MANPATH "" $MANPATH /run/current-system/sw/share/man
          set -gx RIPGREP_CONFIG_PATH ~/.config/ripgreprc
        '';
        loginShellInit = configs ./home/config/fish/login ;
        interactiveShellInit = ''
          stty start undef
          stty stop undef
          stty -ixon
          set -x fish_color_search_match  'normal' '--background=878787'
          bind \e\; 'commandline -r -t (commandline -t | sed \"s/:\(\d*\)/ +\1/\")'
        '' + "\n" + configs ./home/config/fish/interactive ;

      };

      fisher = {
        enable = true;
        packages = ''
          fishpkg/fish-get
          oh-my-fish/plugin-fasd
          jethrokuan/fzf
          nyarly/fish-bang-bang
          nyarly/fish-rake-complete
        '';
      };

      neovim = {
        enable = true;
        configure = {
          customRC = lib.concatStringsSep "\n" (map (p: "\"${p}\n${builtins.readFile p}\n") [
            ./home/config/neovim/init.vim
            ./home/config/neovim/ftdetect/extra_ruby.vim
            ./home/config/neovim/filetype-settings/go.vim
            ./home/config/neovim/filetype-settings/javascript.vim
            ./home/config/neovim/filetype-settings/ruby.vim
            ./home/config/neovim/filetype-settings/rust.vim
            #./home/config/neovim/mapping-scratch.vim
            ./home/config/neovim/motion-join.vim
            ./home/config/neovim/syntax-inspect.vim
            #./home/config/neovim/scratch.vim
            ./home/config/neovim/indent-jump.vim
            ./home/config/neovim/80cols.vim
            ./home/config/neovim/taxo-quickfix.vim
            ./home/config/neovim/out2file.vim
            ./home/config/neovim/bufarg.vim
            ./home/config/neovim/trim-white.vim
            ./home/config/neovim/sticky-window.vim
            ./home/config/neovim/mapping.vim
            ./home/config/neovim/matchit.vim
            ./home/config/neovim/xterm-color-table.vim
            ./home/config/neovim/toggle-folding.vim
            ./home/config/neovim/center-jump.vim
            ./home/config/neovim/SimpleFold.vim
            ./home/config/neovim/blase-swapfile.vim
            ./home/config/neovim/plugin-config/ultisnips.vim
            ./home/config/neovim/plugin-config/yankring.vim
            ./home/config/neovim/plugin-config/tagbar.vim
            ./home/config/neovim/plugin-config/ag.vim
            ./home/config/neovim/plugin-config/deoplete.vim
            ./home/config/neovim/plugin-config/jobmake.vim
            ./home/config/neovim/plugin-config/gpg.vim
            ./home/config/neovim/plugin-config/fzf.vim
            ./home/config/neovim/plugin-config/quickfixsigns.vim
            ./home/config/neovim/plugin-config/neocomplete.vim
            ./home/config/neovim/plugin-config/ale.vim
            ./home/config/neovim/plugin-config/ranger.vim
            #./home/config/neovim/plugin-config/airline.vim
            ./home/config/neovim/plugin-config/indent-guides.vim
            ./home/config/neovim/plugin-config/rainbow.vim
            ./home/config/neovim/plugin-config/tmuxline.vim
            ./home/config/neovim/plugin-config/sideways.vim
            ./home/config/neovim/plugin-config/legend.vim
            ./home/config/neovim/plugin-config/ctrlp.vim
        ]);

        packages.jdlPackages = with pkgs.vimPlugins; with localNvimPlugins; {
          opt = [
            tagbar
          ];
          start = [
            ag-vim
            ale
            vim-closetag
            Colorizer
            deoplete-go
            deoplete-nvim
            deoplete-rust
            direnv-vim
            Dockerfile-vim
            echodoc
            errormarker-vim
            #floobits-neovim # I think it needs it's Python lib...
            fzfWrapper
            fzf-vim
            gist-vim
            gnupg
            godoctor-vim
            gundo
            html5-vim
            IndentAnything
            jobmake
            jq-vim
            lldb-nvim
            nginx-vim
            promptline-vim
            rainbow
            ranger-vim
            rfc-syntax
            rust-vim
            semweb-vim
            sparkup
            sideways-vim
            tabular
            textile-vim
            tmuxline-vim
            ultisnips
            vim-abolish
            vim-actionscript
            vim-coffee-script
            # vim-delve
            vim-endwise
            vim-fish
            vim-fugitive
            vim-go
            vim-indent-guides
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
            vim-airline
            vim-airline-themes
          ];
        };
      };
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
          credentials = "madhelm/judson/8a57d212-0116-49e2-ae55-4bbcbe6dfc01";
        };
      };
    };
  };

  services = {
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
          geometry = "300x5-4+4";
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

    nm-applet.enable = true;

    taffybar.enable = true;
    restartTaffybar.enable = true;
    xembed-sni-proxy.enable = true;

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

    scdaemonNotify.enable = true;

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

    trayer = {
      enable = false;
      setDockType = false;
      setPartialStrut = false;
      widthType = "pixel";
    };

    lorri.enable = true;
  };

  home.file = {
    ".tmux.conf".source = ./home/config/tmux.conf;
    ".local/share/fonts/monofur/monof56.ttf".source = ./home/fonts/monof55.ttf;
    ".local/share/fonts/monofur/monof55.ttf".source = ./home/fonts/monof56.ttf;
    ".ssh/yubi-fd7a96.pub".source = ./home/ssh/yubi-fd7a96.pub;
  };

  xdg.configFile = {
    "nvim/plugin/airline.vim".source = ./home/config/neovim/plugin-config/airline.vim;
    "git/trimwhite.sh".source = ./home/config/git/trimwhite.sh;
    "taffybar/taffybar.hs" = {
      source = ./home/config/taffybar/taffybar.hs;
      onChange = ''
          echo "Restarting taffybar"
          $DRY_RUN_CMD rm ~/.cache/taffybar/taffybar-linux-x86_64
          $DRY_RUN_CMD systemctl --user restart taffybar
      '';
    };
    "taffybar/taffybar.css" = {
      source = ./home/config/taffybar/taffybar.css;
      onChange = ''
          echo "Restarting taffybar"
          $DRY_RUN_CMD systemctl --user restart taffybar
      '';
    };
  } // loadConfigs ./home/config/transitional;

  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = pkgs: [ pkgs.taffybar ];
      config = home/config/xmonad.hs;
    };
  };


  # TODO

  # git_template
  # hexchat
  # fontconfig?
  # gconf ? (nm-manager)
  # mimeapps.conf ?
  # gocode
  # fish functions
  # fish completions
  # fish dir cleanup

  # clobber runit
  # clobber mr
  # clobber vcsh

  #
  # # keynav.service # Seldom used, very flaky. Alternatives?
  #    xmonad config?
  # xembedsniproxy.service # maybe a better choice than trayer?
  #   taffybar has a whole "set up the SNItray first" thing,
  #   which HM might support well.
  # transitional configs
  # NeoVim spit n polish
}
