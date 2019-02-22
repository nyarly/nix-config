{ config, lib, pkgs, ... }:

let
  cfg = config.services.scdaemonNotify;
in

with lib;

{
  # meta.maintainers = [ maintainers.nyarly ];


  options = {
    services.scdaemonNotify = {
      enable = mkEnableOption "SCDaemonNotify";
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.scdaemon-notify = {
      Unit = {
        Description = "Echo GPG events to notify";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${pkgs.socket-notify}/bin/socket-notify";
      };
    };
  };
}
