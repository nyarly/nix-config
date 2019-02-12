{ lib, config, pkgs, ... }:

with lib;

let

  cfg = config.programs.fisher;

  fisher = builtins.fetchurl "https://git.io/fisher";

  fisherPackages = pkgs.callPackage ../plugins/fisher.nix {};

  getPkg = name: fisherPackages.${name};

  getPkgs = with builtins;
    text: concatStringsSep "\n" (map getPkg (filter (s: s != "") (pkgs.lib.splitString "\n" text)));
in
{
  options = {
    programs.fisher = {
      enable = mkEnableOption "fisher fish-shell package manager";

      packages = mkOption {
        default = "";
        description = ''
          Packages to install, one on a line.
          Fisher packages need to be added to the home-manager fisherPackages.
        '';
        example = ''
          fishpkg/fish-get
          oh-my-fish/plugin-fasd
          jethrokuan/fzf
          nyarly/fish-bang-bang
          nyarly/fish-rake-complete
        '';
        type = types.lines;
      };
    };
  };

  config = mkIf cfg.enable {
    programs.fish.enable = true;

    xdg.configFile = {
      "fish/functions/fisher.fish" = {
        source = fisher;
      };

      "fish/hm_fishfile" = {
        text = (getPkgs cfg.packages);
        onChange = ''
          cp ${config.xdg.configHome}/fish/hm_fishfile ${config.xdg.configHome}/fish/fishfile
          chmod u+w ${config.xdg.configHome}/fish/fishfile
          ${pkgs.fish}/bin/fish -c "source ${fisher}; fisher"
        '';
      };
    };
  };
}
