{ lib, config, pkgs, ... }:

let
  vimUtils = pkgs.callPackage (<nixpkgs> + "/pkgs/misc/vim-plugins/vim-utils.nix") {};

  loadConfigs = pkgs.callPackage ./home/loadConfigs.nix {};

  localNvimPlugins = pkgs.callPackage ./personal-nvim-plugins.nix {
    inherit (pkgs) fetchgit;
    inherit (vimUtils) buildVimPluginFrom2Nix;
  };
in
{
  imports = [
    home/fisher.nix
  ];

  home.packages = with pkgs; [
    pv
    exa
  ];

  programs = {
    # Let Home Manager install and manage itself.
    home-manager = {
      enable = true;
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
          set -eg EDITOR # Use set -xU EDITOR and VISUAL
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
          start = [
            ag-vim
            ale
            vim-closetag
            Colorizer
            deoplete-go
            deoplete-nvim
            deoplete-rust
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
            tagbar
            textile-vim
            tmuxline-vim
            ultisnips
            vim-abolish
            vim-actionscript
            vim-airline
            vim-airline-themes
            vim-coffee-script
            vim-delve
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
          ];
        };
      };
    };
  };

  home.file = {
    ".tmux.conf".source = ./home/config/tmux.conf;
    ".local/share/fonts/monofur/monof56.ttf".source = ./home/fonts/monof55;
    ".local/share/fonts/monofur/monof55.ttf".source = ./home/fonts/monof56;
  };

  xdg.configFile = {
    "nvim/plugin/airline.vim".source = ./home/config/neovim/plugin-config/airline.vim;
  } // loadConfigs ./home/config/transitional;

  xsession = {
    enable = true;
    windowManager.command = let
      xmonad = pkgs.xmonad-with-packages.override {
        packages = self: [ self.xmonad-contrib self.taffybar ];
      };
    in
    "${xmonad}/bin/xmonad";
  };


  # TODO
  #
  # dunst
  # gnupg
  # systemd
  # ssh
  # git
}
