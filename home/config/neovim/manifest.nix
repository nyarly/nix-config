lib:
lib.concatStringsSep "\n" (map (p: "\"${p}\n${builtins.readFile p}\n") [
  ./plugin-config/ultisnips.vim
  ./plugin-config/tagbar.vim
  ./plugin-config/jobmake.vim
  ./plugin-config/gpg.vim
  ./plugin-config/fzf.vim
  ./plugin-config/quickfixsigns.vim
  ./plugin-config/deoplete.vim
  ./plugin-config/ale.vim
  ./plugin-config/ranger.vim
  ./plugin-config/rainbow.vim
  ./plugin-config/tmuxline.vim
  ./plugin-config/sideways.vim
  ./plugin-config/legend.vim
  ./plugin-config/ctrlp.vim
  ./plugin-config/airline.vim
  ./plugin-config/IndentLine.vim
  ./plugin-config/vim-markdown.vim
  ./init.vim
  ./packloadall.vim # <<-- this is where plugins load
  ./plugin-config/deoplete-loaded.vim
  ./ftdetect/extra_ruby.vim
  ./filetype-settings/go.vim
  ./filetype-settings/javascript.vim
  ./filetype-settings/ruby.vim
  ./filetype-settings/rust.vim
  ./motion-join.vim
  ./syntax-inspect.vim
  ./indent-jump.vim
  ./80cols.vim
  ./taxo-quickfix.vim
  ./out2file.vim
  ./bufarg.vim
  ./trim-white.vim
  ./sticky-window.vim
  ./mapping.vim
  ./matchit.vim
  ./xterm-color-table.vim
  ./toggle-folding.vim
  ./center-jump.vim
  ./SimpleFold.vim
  ./blase-swapfile.vim
  #./plugin-config/indent-guides.vim
  #./plugin-config/ag.vim
  #./plugin-config/language-client.vim
  #./mapping-scratch.vim
  #./scratch.vim
])
