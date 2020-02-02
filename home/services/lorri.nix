{ config, lib, pkgs, ... }:

with lib;

let
  lorriSrc = builtins.fetchGit {
    url = "https://github.com/nyarly/lorri.git";
    ref = "stream_events";
    rev = "5563ab2e05547a3caac0f95e224571d2bc713252";
  };

  lorri = (lowPrio ((import lorriSrc) {}));

  daemonPath = lib.makeSearchPath "bin" (with pkgs; [ nix gnutar gzip git mercurial ]);

  notifyPath = lib.makeSearchPath "bin" [ pkgs.bash pkgs.jq pkgs.findutils pkgs.libnotify lorri ];

  cfg = config.services.jdl-lorri;

  jqFiles = builtins.readFile ./notify-filter.jq;

  notifyScript = pkgs.writeTextFile {
    name = "lorri_notify";
    executable = true;
    text = ''
            #! /usr/bin/env bash

            lorri internal__stream_events --kind live |\
            jq --unbuffered '${jqFiles}' |\
            xargs -n 1 notify-send "Lorri Build"
    '';
  };

in
  {
    options = {
      services.jdl-lorri = {
        enable = mkEnableOption "jdl-lorri";
      };
    };

    config = mkIf cfg.enable {
      programs.direnv.stdlib = ''
        # from services/lorri.nix
        use_lorri() {
          eval "$(lorri direnv)"
        }
      '';

      home.packages =  [
        lorri
      ];

      systemd.user = {
        sockets.lorri = {
          Unit = { Description = "lorri build daemon"; };
          Socket = { ListenStream = "%t/lorri/daemon.socket"; };
          Install = { WantedBy = [ "sockets.target" ]; };
        };

        services.lorri = {
          Unit = {
            Description = "lorri build daemon";
            Documentation = "https://github.com/target/lorri";
            ConditionUser = "!@system";
            Requires = "lorri.socket";
            After = "lorri.socket";
            RefuseManualStart = true;
          };

          Service = {
            ExecStart = "${lorri}/bin/lorri daemon";
            PrivateTmp = true;
            ProtectSystem = "strict";
            WorkingDirectory = "%h";
            Restart = "on-failure";
            Environment = "PATH=${daemonPath} RUST_BACKTRACE=1";
          };
        };

        services.lorri-notify = {
          Unit = {
            Description = "lorri build notifications";
            After = "lorri.service";
            Requires = "lorri.service";
          };

          Service = {
            ExecStart = toString notifyScript;
            Restart = "on-failure";
            Environment = "PATH=${notifyPath} RUST_BACKTRACE=1";
          };
        };
      };
    };
  }
