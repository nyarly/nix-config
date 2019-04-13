{pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  plugins = [
    "AndrewRadev/sideways.vim"
    "chrisbra/Colorizer"
    "critiqjo/lldb.nvim"
    "dag/vim-fish"
    "edkolev/promptline.vim"
    "ekalinin/Dockerfile.vim"
    "godoctor/godoctor.vim"
    "grensjo/tmuxline.vim"
    "jeroenbourgois/vim-actionscript"
    "killphi/vim-legend"
    "mh21/errormarker.vim"
    "mxw/vim-jsx"
    "nyarly/jobmake"
    "othree/html5.vim"
    "rafaqz/ranger.vim"
    "rking/ag.vim"
    "sebdah/vim-delve"
    "seebi/semweb.vim"
    "timcharper/textile.vim"
    "tpope/vim-endwise"
    "tpope/vim-obsession"
    "tpope/vim-ragtag"
    "tpope/vim-unimpaired"
    "vim-scripts/IndentAnything"
    "vim-scripts/gnupg"
    "vim-scripts/nginx.vim"
    "vim-scripts/rfc-syntax"
    "vito-c/jq.vim"
  ];
  wrapVundle = pname: "{'name': 'github:${pname}'}";
  vamFile = builtins.toFile "plugins.txt" (builtins.concatStringsSep "\n" (map wrapVundle plugins));
  pluginnames2Nix = vimUtils.pluginnames2Nix {
    name = "adhoc-vim-plugins";
    namefiles = [vamFile];
  };
in
  mkShell {
    buildInputs = [ pluginnames2Nix ];
  }

# nix-shell nvim-plugins-shell.nix --command "adhoc-vim-plugins -c '0/# vam/,\$d | x! personal-nvim-plugins-list.nix'"
#
# The resulting output needs to be wrapped in
#{fetchgit, buildVimPluginFrom2Nix}:
#{
#   ...
#}

# It would be nice to set this up as a nix expression and be done, but the pluginnames2Nix thing
# uses Vim's `echom` in its scripts and RC file, which triggers a "Press ENTER" from Vim.
