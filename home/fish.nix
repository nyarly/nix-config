{pkgs, unstable}:
with builtins; let
  configs        = path: concatStringsSep "\n" (map (p: includeFile (path + "/${p}")) (configScripts path));
  includeFile = path: "# start: ${path}\n${readFile path}\n# end: ${path}";
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

  package = (unstable.fish.overrideAttrs (oldAttrs: { cmakeFlags = []; }));

  shellInit = #fish
  ''
    ulimit -n 4096
    function fish_greeting; end
    __refresh_gpg_agent_info
    set -g __fish_git_prompt_show_informative_status yes
    set -gx EDITOR ~/.nix-profile/bin/nvim
    set -gx PAGER "bat"
    set -gx MANPAGER "bat --style=plain"
    set -gx MANPATH "" $MANPATH /run/current-system/sw/share/man
    set -gx RIPGREP_CONFIG_PATH ~/.config/ripgrep/ripgreprc
    set -gx PASSWORD_STORE_X_SELECTION primary
    set -gx PATH /home/judson/bin $PATH
  '';
  loginShellInit = configs config/fish/login ;
  interactiveShellInit = #fish
  ''
    stty start undef
    stty stop undef
    stty -ixon
    set -x fish_color_search_match  'normal' '--background=878787'
    set -x GIT_SSH ssh # Otherwise Go overrides ControlMaster
    set -x BROWSER google-chrome-stable
    set -x EZA_COLORS tm=96 # Tempfiles mid-grey instead of white
    bind \e\; 'commandline -r -t (commandline -t | sed \"s/:\(\d*\)/ +\1/\")'
    direnv export fish | source
  '' + "\n" + configs config/fish/interactive ;

  plugins = import config/fish-plugins.nix { inherit (pkgs) fetchFromGitHub; };
}
