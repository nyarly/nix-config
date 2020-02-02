(if .completed?.nix_file.shell == $shell_nix then "✔" else null end),
(if .failure?.nix_file.shell == $shell_nix then  "✘" else null end),
(if .started?.nix_file.shell == $shell_nix then "⏳" else null end) | values
