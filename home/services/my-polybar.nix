{ config, lib, pkgs, ... }:

with lib;

# homebrewed polybar service to do templated Systemd services for each monitor

# TODO: task hook to list monitors and do automatic setup of services
# XXX: user-generator doesn't seem to do this? investigate via systemd docs
let

  cfg = config.services.myPolybar;

  eitherStrBoolIntList = with types;
    either str (either bool (either int (listOf str)));

  toPolybarIni = generators.toINI {
    mkKeyValue = key: value:
      let
        quoted = v:
          if hasPrefix " " v || hasSuffix " " v then ''"${v}"'' else v;

        value' = if isBool value then
          (if value then "true" else "false")
        else if (isString value && key != "include-file") then
          quoted value
        else
          toString value;
      in "${key}=${value'}";
  };

  configFile = pkgs.writeText "polybar.conf"
    (toPolybarIni cfg.config + "\n" + cfg.extraConfig);

in {
  options = {
    services.myPolybar = {
      enable = mkEnableOption "Polybar status bar";

      package = mkOption {
        type = types.package;
        default = pkgs.polybar;
        defaultText = literalExample "pkgs.polybar";
        description = "Polybar package to install.";
        example = literalExample ''
          pkgs.polybar.override {
            i3GapsSupport = true;
            alsaSupport = true;
            iwSupport = true;
            githubSupport = true;
          }
        '';
      };

      config = mkOption {
        type = types.coercedTo types.path
          (p: { "section/base" = { include-file = "${p}"; }; })
          (types.attrsOf (types.attrsOf eitherStrBoolIntList));
        description = ''
          Polybar configuration. Can be either path to a file, or set of attributes
          that will be used to create the final configuration.
        '';
        default = { };
        example = literalExample ''
          {
            "bar/top" = {
              monitor = "\''${env:MONITOR:eDP-1}";
              width = "100%";
              height = "3%";
              radius = 0;
              modules-center = "date";
            };

            "module/date" = {
              type = "internal/date";
              internal = 5;
              date = "%d.%m.%y";
              time = "%H:%M";
              label = "%time%  %date%";
            };
          }
        '';
      };

      extraConfig = mkOption {
        type = types.lines;
        description = "Additional configuration to add.";
        default = "";
        example = ''
          [module/date]
          type = internal/date
          interval = 5
          date = "%d.%m.%y"
          time = %H:%M
          format-prefix-foreground = \''${colors.foreground-alt}
          label = %time%  %date%
        '';
      };

      barName = mkOption {
        type = types.str;
        default = "main";
        description = ''
          Passed directly to polybar as the chosen menubar.
          Coupled to configuration.
        '';
        example = "%i";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.configFile."polybar/config.ini".source = configFile;

    systemd.user.services."polybar@" = {
      Install.DefaultInstance = "eDP-1"; # XXX configurable

      Unit = {
        Description = "Polybar status bar for monitor %i";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
        X-Restart-Triggers =
          [ "${config.xdg.configFile."polybar/config.ini".source}" ];
      };

      Service = {
        Type = "exec";
        Environment = [
          "MONITOR=%i"
          "PATH=/run/wrappers/bin:${pkgs.gnugrep}/bin"
        ];
        ExecStartPre =
        let checkScript = pkgs.writeShellScriptBin "check-monitor"
        ''
          set -x
          ${cfg.package}/bin/polybar --list-monitors | grep -q "^''${1}:" && exit 0
          ${pkgs.systemd}/bin/systemctl --user disable polybar@''${1}
        '';
          in "${checkScript}/bin/check-monitor %i";
        ExecStart = "${cfg.package}/bin/polybar --reload ${cfg.barName}";
        Restart = "on-failure";
      };
    };
  };

}
