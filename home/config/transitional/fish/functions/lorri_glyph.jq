(if .Completed?.nix_file == $shell_nix then "✔" else null end),
(if .Failure?.nix_file == $shell_nix then  "✘" else null end),
(if .Started?.nix_file == $shell_nix then "⏳" else null end) | values
