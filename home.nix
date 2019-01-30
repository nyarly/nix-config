{ config, pkgs, ... }:

{
  imports = [
    home/fisher.nix
  ];

  home.packages = with pkgs; [
    pv
    exa
  ];
  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    direnv = {
      enable = true;
      stdlib = builtins.readFile ./home/config/direnvrc;
    };

    # XXX Add chruby support (chruby module)
    fish = with builtins; let
      configs        = path: concatStringsSep "\n" (map (p: readFile (path + ("/" + p))) (configScripts path));
      configScripts  = path: filterDir (configMatch "fish") (readDir path);
      filterDir      = f: ds: filter (n: f n ds.${n}) (attrNames ds);
      configMatch    = ext: path: type: let
          extPattern = ".*[.]${ext}$";
          isDir = type != "directory";
          isExt = match extPattern path != null;
        in
          isDir && isExt;
    in
      {
        enable = true;
        shellInit = ''
          ulimit -n 4096
          function fish_greeting; end
          __refresh_gpg_agent_info
        '';
        loginShellInit = ''
          set -g __fish_git_prompt_show_informative_status yes
          set -eg EDITOR # Use set -xU EDITOR and VISUAL
          set -gx PAGER "less -RF"
          set -gx MANPATH "" $MANPATH /run/current-system/sw/share/man
          set -gx RIPGREP_CONFIG_PATH ~/.config/ripgreprc
        '' + "\n" + configs ./home/config/fish/login ;
        interactiveShellInit = ''
          stty start undef
          stty stop undef
          stty -ixon
          set -x fish_color_search_match  'normal' '--background=878787'
          bind \e\; 'commandline -r -t (commandline -t | sed \"s/:\(\d*\)/ +\1/\")'
        '' + "\n" + configs ./home/config/fish/interactive ;

      };

    fisher = {
      enable = true;
      packages = ''
        fishpkg/fish-get
        oh-my-fish/plugin-fasd
        jethrokuan/fzf
        nyarly/fish-bang-bang
        nyarly/fish-rake-complete
      '';
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
