lib:
let
  luaFiles = builtins.attrNames (lib.filterAttrs (n: v: (v == "regular") && (builtins.match ".*[.]lua" n) != null) (builtins.readDir ./plugin-config));
in
lib.concatStringsSep "\n" (map (p: "\"${p}\n${builtins.readFile (./plugin-config + "/${p}")}\n") luaFiles)
