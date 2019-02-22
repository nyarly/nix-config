{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.trayer;

  params = cfg: concatStringsSep " " (
    optional (cfg.setDockType != null) "--SetDockType ${boolToString cfg.setDockType}"
    ++ optional (cfg.setPartialStrut != null) "--SetPartialStrut ${boolToString cfg.setPartialStrut}"
    ++ optional (cfg.widthType != null) "--widthtype ${cfg.widthType}"
    ++ optional (cfg.width != null) "--width ${cfg.width}"
    ++ optional (cfg.heightType != null) "--heighttype ${cfg.heightType}"
    ++ optional (cfg.height != null) "--height ${cfg.height}"
    );
in


{
  # meta.maintainers = [ maintainers.nyarly ];


  options = {
    services.trayer = {
      enable = mkEnableOption "Trayer";

      setDockType = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = "Whether the tray should be docked.";
      };

      setPartialStrut = mkOption {
        type = types.nullOr types.bool;
        default = null;
      };

      width = mkOption {
        type = types.nullOr types.int;
        default = null;
      };

      widthType = mkOption {
        type = types.nullOr (types.enum ["request" "pixel" "percent"]);
        default = null;
      };

      height = mkOption {
        type = types.nullOr types.int;
        default = null;
      };

      heightType = mkOption {
        type = types.nullOr (types.enum ["request" "pixel"]);
        default = null;
      };
    };
  };

  config = mkIf cfg.enable {

    systemd.user.services.trayer = {
      Unit = {
        Description = "Trayer XEmbed Host";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart="${pkgs.trayer}/bin/trayer ${params cfg}";
      };
    };
  };
}
