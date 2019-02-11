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
    home-manager.enable = true;

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
        customRC = ''
        set nocompatible

        if &shell =~# 'fish$'
          set shell=/bin/sh
        endif

        runtime! ftdetect/UltiSnips.vim

        set autowrite
        set autowriteall
        set expandtab
        set modeline
        set sw=2
        set ts=2
        set scrolloff=4
        set pastetoggle=[23~
        set gdefault
        set mouse=a

        "O	message for reading a file overwrites any previous message.
        "Also for quickfix message (e.g., ":cn").
        "t	truncate file message at the start if it is too long to fit
        "T	truncate other messages in the middle if they are too long to
        "I	don't give the intro message when starting Vim |:intro|.
        "c	don't give |ins-completion-menu| messages.  For example,
        "   c really useful for echodoc
        set shortmess+=IcOtT
        set number
        "set relativenumber "more confusing than useful
        set cursorline
        set noshowmode
        set foldlevelstart=2
        set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20

        set title

        set wildmode=list:longest

        set undodir="~/.vim/undo"
        set undofile

        set clipboard+=unnamed
        set clipboard+=unnamedplus

        set t_ut= "Needed to get non-text background colors to work correctly in urxvt + tmux

        let g:solarized_termcolors=16
        set background=light
        colorscheme solarized
        nnoremap <F12> "*p

        set tags+=.git/bundle-tags

        if exists("$EXTRA_VIM")
          for path in split($EXTRA_VIM, ':')
            exec "source " .path
          endfor
        endif

        set inccommand=split
        " Debugging my 'number' getting disabled:
        " c.f. https://github.com/neovim/neovim/issues/8739
        " au OptionSet number echom execute('verbose set number?')
        '';
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
            floobits-neovim
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
  };

  xdg.configFile = {
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
  # fonts
  # dunst
  # xmonad
  # taffybar
  # gnupg
  # systemd
  # ssh
  # git
  # neovim
  #   VimPlug

}
