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

  sternPathsUnder = processPathsUnder (prefix: name: (addName prefix (lib.traceValFn (n: "File in transition: ${n}") name)) );

  laxPathsUnder = processPathsUnder addName;

  addName = prefix: name: concatStringsSep "/" (prefix ++ [name]);

  buildXdgConfig = src: tgt: path: lib.nameValuePair (addName [tgt] path) { source = src + "/${path}"; };
in
  {
    transitionalConfigs = dir: lib.traceVal ( listToAttrs (map (buildXdgConfig dir ".") (sternPathsUnder dir [])));
    configFiles = src: tgt: listToAttrs (map (buildXdgConfig src tgt) (laxPathsUnder src []));
  }
