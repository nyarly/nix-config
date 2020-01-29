function lorri_glyph -a shell_nix
  lorri stream_events_ -k snapshot | jq -r --arg shell_nix $shell_nix -f ~/.config/fish/functions/lorri_glyph.jq
end
