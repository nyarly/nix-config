{ config, lib, pkgs, ... }:

let
  cfg = config.services.scdaemonNotify;
in

with lib;

{
  # meta.maintainers = [ maintainers.nyarly ];

  imports = [ ../programs/scdaemon.nix ];

  options = {
    services.scdaemonNotify = {
      enable = mkEnableOption "SCDaemonNotify";
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      (self: super: {
        socket-notify = pkgs.callPackage ../packages/socket-notify.nix {};
      })
    ];

    programs.scdaemon = {
      enable = true;
      logFile = "socket:///tmp/scdaemon.sock";
      debug = {
        commandIO = true;
        bigIntegers = true;
        traceAssuan = true;
      };

      assuanLogCats =  {
        init = true;
        context = true;
        engine = true;
        data = true;
        sysio = true;
        control = true;
      };
    };

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
