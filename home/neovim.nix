{lib, pkgs}:
let
  localNvimPlugins = pkgs.callPackage ./personal-nvim-plugins.nix {
    inherit (pkgs) fetchgit;
    inherit (pkgs.vimUtils) buildVimPlugin;
  };
in {
  enable = true;
  # package = unstable.neovim-unwrapped;
  extraConfig = (import config/neovim/manifest.nix) lib;
  #withNodeJs = true; # defaults false

  extraPackages = with pkgs; [
    gopls
    nil #nix LS
    impl

    go_1_23
    elmPackages.elm
    elmPackages.elm-test
    elmPackages.elm-format
    elmPackages.elm-language-server
    terraform-ls
    opentofu # needed by terraform-ls
    tflint
    languagetool
    proselint
    vale
    ranger # in vim
    pyright
    lua-language-server # silly not to have an LSP for Lua in Neovim
    yaml-language-server
    cue
  ];

  plugins =
  let
    luaConfig = name: ''

    -- c.f. plugin-config/${name}.lua

    ;(function()
      ${builtins.readFile (config/neovim/plugin-config + "/${name}.lua")}
    end)()
    '';
    dotVim = name: {
      plugin = if pkgs.vimPlugins ? ${name} then pkgs.vimPlugins.${name} else localNvimPlugins.${name};
      config = "\n" + builtins.readFile (config/neovim/plugin-config + "/${name}.vim");
    };
    dotLua = name: {
      plugin = pkgs.vimPlugins.${name};
      type = "lua";
      config = luaConfig name;
    };
  in
  with pkgs.vimPlugins; with localNvimPlugins; [
    (dotLua "nvim-solarized-lua")
    {
      plugin = nvim-treesitter.withAllGrammars;
      type = "lua";
      config = luaConfig "nvim-treesitter";
    }
    nvim-treesitter-textobjects
    (dotVim "ale")
    Colorizer
    (dotLua "fidget-nvim")

    nvim-lspconfig
    rust-tools-nvim
    (dotLua "cmp-nvim-lsp") # depends on nvim-lspconfig and rust-tools-nvim

    (dotLua "luasnip")
    friendly-snippets
    cmp_luasnip
    cmp-buffer
    cmp-path
    cmp-cmdline
    cmp-treesitter
    cmp-conventionalcommits
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
    (dotLua "nvim-treesitter-context")
    (dotLua "zk-nvim")
  ];
}
