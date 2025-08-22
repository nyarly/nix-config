function __tf_rm_it --argument-names abbr_token
  echo "terraform state rm '"(xclip -o)"'"
end

abbr -a -g -- tfrm -f __tf_rm_it
