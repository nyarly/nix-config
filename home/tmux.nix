{pkgs}:
{
  enable = true;
  plugins = with pkgs.tmuxPlugins; [{
      plugin = tmux-thumbs;
      extraConfig = ''
      set -g @thumbs-unique enabled
      set -g @thumbs-reverse enabled
      set -g @thumbs-hint-fg-color black
      set -g @thumbs-hint-bg-color cyan
      set -g @thumbs-bg-color white
      set -g @thumbs-fg-color green
      '';
  }];

  extraConfig = (builtins.readFile config/tmux.conf);
}
