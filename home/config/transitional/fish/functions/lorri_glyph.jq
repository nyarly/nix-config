(if .completed?.nix_file.Shell == $shell_nix then "✔" else null end),
(if .failure?.nix_file.Shell == $shell_nix then  "✘" else null end),
(if .started?.nix_file.Shell == $shell_nix then "⏳" else null end) | values
