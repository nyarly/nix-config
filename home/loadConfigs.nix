{ lib, ... }:
with builtins;
let
  pathsUnder = dir: prefix: let
    paths = readDir dir;
  in lib.concatMap (
    name: if paths.${name} == "directory" then
      pathsUnder (dir + "/${name}") (prefix ++ [name])
    else
      [ (addName prefix (lib.traceValFn (n: "File in transition: ${n}") name)) ]
  ) (attrNames paths);

  addName = prefix: name: concatStringsSep "/" (prefix ++ [name]);

  buildXdgConfig = dir: path: lib.nameValuePair path { source = dir + "/${path}"; };
in
  dir: listToAttrs (map (buildXdgConfig dir) (pathsUnder dir []))
