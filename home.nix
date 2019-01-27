{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

    direnv = {
      enable = true;
      stdlib = builtins.readFile ./home/config/direnvrc;
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
