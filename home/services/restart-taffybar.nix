{ config, lib, pkgs, ... }:

let
  cfg = config.services.restartTaffybar;
in

with lib;

{
  # meta.maintainers = [ maintainers.nyarly ];

  options = {
    services.restartTaffybar = {
      enable = mkEnableOption "Periodic restart of Taffybar";
    };
  };

  config = mkIf cfg.enable {
    systemd.user.timers.restart-taffybar = {
      Unit = {
        Description="Restart Taffybar in the wee hours";
      };

      Timer = {
        OnCalendar="*-*-* 02:00:00";
      };
    };

    systemd.user.services.restart-taffybar = {
      Unit = {
        Description="Restart Taffybar";
        After = [ "taffybar" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        Type="oneshot";
        ExecStart="/run/current-system/sw/bin/systemctl --user try-restart taffybar";
      };

      Install = {
        WantedBy = "graphical-session.target";
      };
    };
  };
}
