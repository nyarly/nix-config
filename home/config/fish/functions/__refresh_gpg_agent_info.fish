function __refresh_gpg_agent_info --description 'Reload ~/.gpg-agent-info'
	if not test -c $GPG_TTY
    set -x GPG_TTY (tty)
  end
  if set -q $XDG_RUNTIME_DIR
    set sock "$XDG_RUNTIME_DIR"/gnupg/S.gpg-agent.ssh
  else
    set sock /run/user/(id -u)/gnupg/S.gpg-agent.ssh
  end

  set -g SSH_AUTH_SOCK $sock
end
