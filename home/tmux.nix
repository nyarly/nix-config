{pkgs}:
{
  enable = true;
  plugins = with pkgs.tmuxPlugins; [{
    plugin = extrakto;
  }];

  extraConfig = (builtins.readFile config/tmux.conf);
}
