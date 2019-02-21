{ config, lib, pkgs, ... }:

let
  cfg = config.services.nitrogen;
in

with lib;

{
  # meta.maintainers = [ maintainers.nyarly ];


  options = {
    services.nitrogen = {
      enable = mkEnableOption "Nitrogen";

      extraConfig = mkOption {
        type = types.lines;
        default = "";
        description = "Verbatim configuration for nitrogen.";
      };
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile = {
      "nitrogen/nitrogen.cfg".text = cfg.extraConfig;
    };

    systemd.user.services.nitrogen = {
      Unit = {
        Description = "Nitrogen desktop image service";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${pkgs.nitrogen}/bin/nitrogen --restore";
      };
    };
  };
}
