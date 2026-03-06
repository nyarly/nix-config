lib:
let
  luaDir = ./lua-config;
  luaFiles = builtins.attrNames (
    lib.filterAttrs (n: v: (v == "regular") && (builtins.match ".*[.]lua" n) != null) (
      builtins.readDir luaDir
    )
  );
  config = lib.concatStringsSep "\n" (
    map (p: "\"${p}\n${builtins.readFile (luaDir + "/${p}")}\n") luaFiles
  );
in
config
