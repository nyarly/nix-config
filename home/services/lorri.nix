{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.jdl-lorri;

  jqFile = ''
    (
      (.Started?   | values | "Build starting in \(.nix_file)"),
      (.Completed? | values | "Build complete in \(.nix_file)"),
      (.Failure?   | values | "Build failed in \(.nix_file)")
    )
  '';

  notifyScript = pkgs.writeTextFile {
    name = "lorri_notify";
    executable = true;
    text = ''
      #! /usr/bin/env bash

      lorri internal stream-events --kind live |\
      jq --unbuffered '${jqFile}' |\
      xargs -n 1 notify-send "Lorri Build"
    '';
  };

in
  {
    options.services.jdl-lorri = {
      enable = mkEnableOption "jdl-lorri";

      package = mkOption {
        type = types.package;
        default = pkgs.lorri;
        defaultText = literalExpression "pkgs.lorri";
        description = "Which lorri package to install.";
      };

      nixPackage = mkOption {
        type = types.package;
        default = pkgs.nix;
        defaultText = literalExpression "pkgs.nix";
        description = "Which nix package to use.";
      };
    };

    config = mkIf cfg.enable {

      home.packages =  [
        cfg.package
      ];

      systemd.user = {
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
            ExecStart = "${cfg.package}/bin/lorri daemon";
            PrivateTmp = true;
            ProtectSystem = "strict";
            WorkingDirectory = "%h";
            Restart = "on-failure";
            Environment = let
              path = with pkgs;
                makeSearchPath "bin" [ cfg.nixPackage gnutar gzip git mercurial ];
            in "PATH=${path} RUST_BACKTRACE=1";
          };
        };

        sockets.lorri = {
          Unit = { Description = "lorri build daemon"; };
          Socket = {
            ListenStream = "%t/lorri/daemon.socket";
            RuntimeDirectory = "lorri";
          };
          Install = { WantedBy = [ "sockets.target" ]; };
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
            Environment = let
              path = with pkgs;
                makeSearchPath "bin" [ bash jq findutils libnotify cfg.package ];
            in "PATH=${path} RUST_BACKTRACE=1";
          };
        };
      };
    };
  }
