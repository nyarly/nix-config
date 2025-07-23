function clobber_history
  echo
	history --delete --prefix (commandline)
  commandline ""
end
