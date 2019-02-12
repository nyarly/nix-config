{pkgs, ...}:
let
  fisherBuilder = builtins.toFile "fisherBuilder.sh" ''
    source $stdenv/setup

    cd $src
    mkdir -p $out
    find . -type d -exec mkdir -p $out/\{\} \; -o -type f -not -name "fishfile" -exec cp \{\} $out/\{\} \;
    if [ -f fishfile ]; then
      diff <(sort $sourceFFPath) <(sort fishfile) || (echo "fishfile not as expected!"; cat fishfile; exit 1)
      cp $targetFFPath $out/fishfile
    fi
  '';

  mkFisherPkg = { pkgName, rev, sha256, deps ? {} }: with builtins; let
    ownerRepo = split "/" pkgName;
    owner = elemAt ownerRepo 0;
    repo = elemAt ownerRepo 2;
    sourceFF = (concatStringsSep "\n" (sort lessThan (attrNames deps))) + "\n";
    targetFF = (concatStringsSep "\n" (sort lessThan (map toString (attrValues deps)))) + "\n";
  in
    pkgs.stdenv.mkDerivation {
      name = builtins.replaceStrings ["/"] ["_"] pkgName;
      src = pkgs.fetchFromGitHub { inherit owner repo rev sha256; };
      builder = fisherBuilder;
      inherit sourceFF targetFF;
      passAsFile = [ "sourceFF" "targetFF" ];
    };

in
   rec {
    "fishpkg/fish-await" = mkFisherPkg {
      pkgName = "fishpkg/fish-await";
      rev = "a9051fef63fb71739287fd067fd6ed179ffb38c8";
      sha256 = "1grc1wp12sfrxsavxny54x8j3w46wfr11yljzqjfihpvk41i7g0c";
      deps = { inherit "fishpkg/fish-last-job-id"; };
    };
    "fishpkg/fish-last-job-id" = mkFisherPkg {
      pkgName = "fishpkg/fish-last-job-id";
      rev = "1ffd5cdef872b9603c0718c05cdcffc0edc960af";
      sha256 = "0gq4956s4m4vnnmrg2y2npw914b50plrj8a3fqmf3p0nlhmvq7l1";
    };
    "fishpkg/fish-get" = mkFisherPkg {
      pkgName = "fishpkg/fish-get";
      rev = "b803b0e5b38054e62c319cd2d4a506498c7aa596";
      sha256 = "13iwy75kbynpvivxbaavcac16hr3fns64n7s02fn0v48ca81j8sr";
      deps = { inherit "jorgebucaran/fish-getopts"; };
    };
    "oh-my-fish/plugin-fasd" = mkFisherPkg {
      pkgName = "oh-my-fish/plugin-fasd";
      rev = "38a5b6b6011106092009549e52249c6d6f501fba";
      sha256 = "06v37hqy5yrv5a6ssd1p3cjd9y3hnp19d3ab7dag56fs1qmgyhbs";
    };
    "jethrokuan/fzf" = mkFisherPkg {
      pkgName = "jethrokuan/fzf";
      rev = "640e9cf3f9dc492550f676d9c552d0e5d686b4f3";
      sha256 = "0n3nzyzp04f0gzxjdhv2429xzz7nyjm6wj9l7igkdm60c5rs1q5q";
    };
    "jorgebucaran/fish-getopts" = mkFisherPkg {
      pkgName = "jorgebucaran/fish-getopts";
      rev = "f57df421df89cfcd5a17cb55ad84614675e250fd";
      sha256 = "17a3wrdb2gkzw1lygxsyryaq5l0np0k2fhaqihhrmnn7ss25m0q3";
    };
    "nyarly/fish-bang-bang" = mkFisherPkg {
      pkgName = "nyarly/fish-bang-bang";
      rev = "12f08d9c81dc23fc44eb309964c7b418bbc97cbb";
      sha256 = "0mzbz0kdg8ax6q1gzsfvpy25d3xqwkyx9hy0jmbkr9zvjf4qav7b";
    };
    "nyarly/fish-cache-file" = mkFisherPkg {
      pkgName = "nyarly/fish-cache-file";
      rev = "ff7490e7dd8a36ce770a8eb96ab5cdb0454e8a8d";
      sha256 = "0rv4p0d1lc4h0w14857ry541jgwj0b26bhnbh1s8v4g1apm4rxg0";
      deps = { inherit "nyarly/lookup"; };
    };
    "nyarly/lookup" = mkFisherPkg {
      pkgName = "nyarly/lookup";
      rev = "c96adbfda19464bc9b463d67906634fbb9cddd5b";
      sha256 = "0id3glqn126y4k9ql37pwzwlphf35sg785vhxyw90zsi37p7vz9s";
    };
    "nyarly/fish-rake-complete" = mkFisherPkg {
      pkgName = "nyarly/fish-rake-complete";
      rev = "5f1999c952f9602c753dbec830f6396adb3c692e";
      sha256 = "1hyf4h9xd4x70l0pfqxf4ahm3ykb29p8xb24s3034djsvawzsv4n";
      deps = { inherit "nyarly/fish-cache-file"; };
    };
  }
