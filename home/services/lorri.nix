{ config, lib, pkgs, ... }:

with lib;

let
  lorriSrc = builtins.fetchGit {
    url = "https://github.com/nyarly/lorri.git";
    ref = "stream_events";
    rev = "a227d9a5b3ad74ef8e04d820d4950abcab80d77c";
  };

  lorri = (lowPrio ((import lorriSrc) {}));

  daemonPath = lib.makeSearchPath "bin" (with pkgs; [ nix gnutar gzip git mercurial ]);

  notifyPath = lib.makeSearchPath "bin" [ pkgs.bash pkgs.jq pkgs.findutils pkgs.libnotify lorri ];

  cfg = config.services.lorri;

  notifyScript = pkgs.writeTextFile {
    name = "lorri_notify";
    executable = true;
    text = ''
            #! /usr/bin/env bash

            lorri stream_events_ --kind live |\
            jq --unbuffered \
            '((.completed?|values|"Build complete in \(.nix_file)"),
            (.failure? |values|"Build failed in \(.nix_file)"))' |\
            xargs -n 1 notify-send "Lorri Build"
    '';
  };

in
  {
    options = {
      services.lorri = {
        enable = mkEnableOption "lorri";
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

      systemd.user.sockets.lorri = {
        Unit = { Description = "lorri build daemon"; };
        Socket = { ListenStream = "%t/lorri/daemon.socket"; };
        Install = { WantedBy = [ "sockets.target" ]; };
      };

      systemd.user.services.lorri = {
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

      systemd.user.services.lorri-notify = {
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
  }
