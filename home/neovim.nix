{lib, pkgs, unstable}:
let
  localNvimPlugins = pkgs.callPackage ./personal-nvim-plugins.nix {
    inherit (pkgs) fetchgit;
    inherit (pkgs.vimUtils) buildVimPlugin;
  };
  vim-nixhash = unstable.vimPlugins.vim-nixhash;
in {
  enable = true;
  package = unstable.neovim-unwrapped;
  extraConfig = (import config/neovim/manifest.nix) lib;
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
      config = builtins.readFile (config/neovim/plugin-config + "/${name}.vim");
    };
    dotLua = name: {
      plugin = pkgs.vimPlugins.${name};
      type = "lua";
      config = builtins.readFile (config/neovim/plugin-config + "/${name}.lua");
    };
  in
  with pkgs.vimPlugins; with localNvimPlugins; [
    { plugin = NeoSolarized; config = ''colorscheme NeoSolarized''; }
    {
      plugin = nvim-treesitter.withAllGrammars;
      type = "lua";
      config = builtins.readFile config/neovim/plugin-config/nvim-treesitter.lua;
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

    sparkup
  ];
}
