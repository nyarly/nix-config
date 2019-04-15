
{ config, lib, pkgs, ... }:

with lib;

let
  lorriSrc = builtins.fetchGit {
    url = "https://github.com/target/lorri.git";
    ref = "rolling-release";
  };

  lorri = pkgs.callPackage lorriSrc {
    src = lorriSrc;
  };

  cfg = config.services.lorri;
in
  {
    options = {
      services.lorri = {
        enable = mkEnableOption "lorri";
      };
    };
    config = mkIf cfg.enable {
      programs.direnv.stdlib = ''
        use_lorri() {
          eval "$(lorri direnv)"
          systemctl --user start lorri@$(systemd-escape $(pwd))
        }
      '';

      home.packages =  [
        lorri
      ];

      systemd.user.services = {
        "lorri@" = {
          Unit = {
            ConditionPathExists="%I";
            ConditionUser="!@system";
            Description="Lorri Watch";
          };

          Service = {
            Environment= [
              "LOCALE_ARCHIVE=/nix/store/k1mlzmf7czx6xpizqwnj4fyd62c65qlw-glibc-locales-2.27/lib/locale/locale-archive"
              "PATH=/run/wrappers/bin:%h/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin:/nix/store/6w3670wdhf83b9xj0wnyq4s9yz7gfvr6-libnotify-0.7.7/bin:/nix/store/d9s1kq1bnwqgxwcvv4zrc36ysnxg8gv7-coreutils-8.30/bin:/nix/store/krhqmaqal0gklh15rs2bwrqzz8mg9lrn-findutils-4.6.0/bin:/nix/store/wnjv27b3j6jfdl0968xpcymlc7chpqil-gnugrep-3.3/bin:/nix/store/x1khw8x0465xhkv6w31af75syyyxc65j-gnused-4.7/bin:/nix/store/rl4ky8x58ixnfjssliygq7iwyd30l3gn-systemd-239.20190219/bin:/run/wrappers/sbin:%h/.nix-profile/sbin:/nix/var/nix/profiles/default/sbin:/run/current-system/sw/sbin:/nix/store/6w3670wdhf83b9xj0wnyq4s9yz7gfvr6-libnotify-0.7.7/sbin:/nix/store/d9s1kq1bnwqgxwcvv4zrc36ysnxg8gv7-coreutils-8.30/sbin:/nix/store/krhqmaqal0gklh15rs2bwrqzz8mg9lrn-findutils-4.6.0/sbin:/nix/store/wnjv27b3j6jfdl0968xpcymlc7chpqil-gnugrep-3.3/sbin:/nix/store/x1khw8x0465xhkv6w31af75syyyxc65j-gnused-4.7/sbin:/nix/store/rl4ky8x58ixnfjssliygq7iwyd30l3gn-systemd-239.20190219/sbin"
              #"TZ=Asia/Singapore"
              #"TZDIR=/nix/store/izrzziiaa27bf9rbdb8hy867vxfjfzbi-tzdata-2018g/share/zoneinfo"
            ];

            ExecStart="%h/.nix-profile/bin/lorri watch";
            PrivateTmp=true;
            ProtectSystem="full";
            Restart="on-failure";
            WorkingDirectory="%I";
          };
        };
      };
    };
  }
