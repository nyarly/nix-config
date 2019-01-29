{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

    direnv = {
      enable = true;
      stdlib = builtins.readFile ./home/config/direnvrc;
    };

    # XXX Add chruby support (chruby module)
    #
    fish = let
      filterDir = f: ds: filter (n: f n ds[n]) (builtins.attrNames ds);
      configScripts = path: filterDir (path: type: type != "directory" && builtins.match "[.]fish$" path) (builtins.readDir path);
      configs = path: map (p: builtins.readFile (path + p)) (configScripts path);
    in
      {
        enable = true;
        shellInit = [
          "ulimit -n 4096"
          ''
          function fish_greeting
          end
          ''
          "__refresh_gpg_agent_info"
        ];
        loginShellInit = [
          "set -g __fish_git_prompt_show_informative_status yes"
          "set -eg EDITOR # Use set -xU EDITOR and VISUAL"
          "set -gx PAGER \"less -RF\""
          "set -gx MANPATH \"\" $MANPATH /run/current-system/sw/share/man"
          "set -gx RIPGREP_CONFIG_PATH ~/.config/ripgreprc"
        ] + configs ./home/config/fish/login ;
        interactiveShellInit = [
          "stty start undef"
          "stty stop undef"
          "stty -ixon"
          "set -x fish_color_search_match  'normal' '--background=878787'"
          "bind \e\; 'commandline -r -t (commandline -t | sed \"s/:\(\d*\)/ +\1/\")'"
        ] + configs ./home/config/fish/interactive ;

      };
  };


  xsession = {
    enable = true;
    windowManager.command = let
      xmonad = pkgs.xmonad-with-packages.override {
        packages = self: [ self.xmonad-contrib self.taffybar ];
      };
    in
      "${xmonad}/bin/xmonad";
  };
}
