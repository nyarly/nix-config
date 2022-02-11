function lorri_glyph -a shell_nix
  lorri internal stream-events --kind snapshot | grep -v '\bERRO\b' | jq -r --arg shell_nix $shell_nix -f ~/.config/fish/functions/lorri_glyph.jq
end
