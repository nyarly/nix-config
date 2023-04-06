lib:
let
  luaFiles = attrNames (lib.filterAttrs (n: v: v == "regular" && builtins.match "[.]lua$" n) (builtins.readDir ./plugin-config));
in
lib.concatStringsSep "\n" (map (p: "\"${p}\n${builtins.readFile p}\n") luaFiles)
