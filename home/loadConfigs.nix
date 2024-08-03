{ lib, ... }:
with builtins;
let
  processPathsUnder = fileHandler: dir: prefix: let
    paths = readDir dir;
  in lib.concatMap (
    name: if paths.${name} == "directory" then
      processPathsUnder fileHandler (dir + "/${name}") (prefix ++ [name])
    else
      [ (fileHandler prefix name) ]
  ) (attrNames paths);

  laxPathsUnder = processPathsUnder addName;

  addName = prefix: name: concatStringsSep "/" (prefix ++ [name]);

  buildXdgConfig = src: tgt: path: lib.nameValuePair (addName [tgt] path) { source = src + "/${path}"; };
in
  {
    configFiles = src: tgt: listToAttrs (map (buildXdgConfig src tgt) (laxPathsUnder src []));
  }
