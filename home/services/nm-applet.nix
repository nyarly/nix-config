{ config, lib, pkgs, ... }:

let
  cfg = config.services.nm-applet;
in

with lib;

{
  # meta.maintainers = [ maintainers.nyarly ];


  options = {
    services.nm-applet = {
      enable = mkEnableOption "nm-applet";
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.nm-applet = {
      Unit = {
        Description = "Network Manager Applet";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
      };
    };
  };
}
