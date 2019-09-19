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
    "hwayne/tla.vim"
  ];
  wrapVundle = pname: "{'name': 'github:${pname}'}";
  vamFile = builtins.toFile "plugins.txt" (builtins.concatStringsSep "\n" (map wrapVundle plugins));
  pluginnames2Nix = vimUtils.pluginnames2Nix {
    name = "adhoc-vim-plugins";
    namefiles = [vamFile];
  };
in
  # likely the wrong approach: VAM wants to fetch stuff off the network, which should happen in the source phase...
  stdenv.mkDerivation {
    name = "jdl-personal-nvim-plugins";

    buildInputs = [ pluginnames2Nix ];

    buildPhase = ''
      yes "" | adhoc-vim-plugins -c '0/# vam/,\$d | x! start.nix'"

      echo << EOH > list.nix
      {fetchgit, buildVimPluginFrom2Nix}:
      {
      EOH

      cat start.nix >> list.nix

      echo "}" >> list.nix
    '';

    installPhase = ''
      mv list.nix $out
    '';
  }
