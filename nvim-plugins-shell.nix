{pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  pluginnames2Nix = vimUtils.pluginnames2Nix {
    name = "adhoc-vim-plugins";
    namefiles = [./from_plug.txt];
  };
in
  mkShell {
    buildInputs = [ pluginnames2Nix ];
  }

# nix-shell nvim-plugins-shell.nix --command "adhoc-vim-plugins +'x! personal-nvim-plugins.nix"
