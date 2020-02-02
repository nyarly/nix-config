{ config, lib, pkgs, ... }:
with lib;

let
  inherit (attrsets) attrVals;
  inherit (builtins) foldl' trace;

  cfg = config.programs.scdaemon;

  bitfield = bools: foldl' (n: b: n * 2 + (if b then 1 else 0)) 0  bools;

  debugBitmask = mod: bitfield (attrVals [
    "traceCardFunctions" "traceAPDU" "traceAssuan" "writeHashedData"
    "dummy" # GnuPG skips a bits here
    "memoryStats" "caching" "memoryAllocation"
    "dummy" "dummy" # and another two
    "lowLevelCrypto" "bigIntegers" "commandIO"
  ] (mod // {dummy = false;}));

  assuanCatsBitmask = mod: bitfield (attrVals [
    "control"
    "dummy" "dummy" # what is it with skipping bits?
    "sysio" "data" "engine" "context" "init"
  ] (mod // {dummy = false;}));

  buildScdaemonConf = cfg: concatStringsSep "\n" (
    optional (cfg.logFile != null) "log-file ${cfg.logFile}"
    ++ optional (debugBitmask cfg.debug > 0) "debug ${toString (debugBitmask cfg.debug)}"
    ++ optional (assuanCatsBitmask cfg.assuanLogCats > 0) "debug-assuan-log-cats ${toString (assuanCatsBitmask cfg.assuanLogCats)}"
  ) + "\n";
in
{
  options = {
    programs.scdaemon = {
      enable = mkEnableOption "Configure the GnuPG scdaemon";

      logFile = mkOption {
        type = types.nullOr types.lines;
        default = null;
      };

      debug = mkOption {
        type = types.submodule {
          options = {
            commandIO = mkOption {
              type = types.bool;
              default = false;
            };
            bigIntegers = mkOption {
              type = types.bool;
              default = false;
            };
            lowLevelCrypto = mkOption {
              type = types.bool;
              default = false;
            };
            memoryAllocation = mkOption {
              type = types.bool;
              default = false;
            };
            caching = mkOption {
              type = types.bool;
              default = false;
            };
            memoryStats = mkOption {
              type = types.bool;
              default = false;
            };
            writeHashedData = mkOption {
              type = types.bool;
              default = false;
            };
            traceAssuan = mkOption {
              type = types.bool;
              default = false;
            };
            traceAPDU = mkOption {
              type = types.bool;
              default = false;
            };
            traceCardFunctions = mkOption {
              type = types.bool;
              default = false;
            };
          };
        };
      };

      assuanLogCats = mkOption {
        type = types.submodule {
          options = {
            init = mkOption {
              type = types.bool;
              default = false;
            };
            context = mkOption {
              type = types.bool;
              default = false;
            };
            engine = mkOption {
              type = types.bool;
              default = false;
            };
            data = mkOption {
              type = types.bool;
              default = false;
            };
            sysio = mkOption {
              type = types.bool;
              default = false;
            };
            control = mkOption {
              type = types.bool;
              default = false;
            };
          };
        };
      };

    };
  };

  config = mkIf cfg.enable {
    home.file.".gnupg/scdaemon.conf" = {
      text = buildScdaemonConf cfg;
    };
  };
}
