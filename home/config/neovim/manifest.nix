lib:
lib.concatStringsSep "\n" (map (p: "\"${p}\n${builtins.readFile p}\n") [
  ./init.vim
  ./packloadall.vim # <<-- this is where plugins load
  ./ftdetect/extra_ruby.vim

  # see also ftplugin/ files which are copied into place for lazy loads
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
  ./blase-swapfile.vim
  ./colors.vim
])
