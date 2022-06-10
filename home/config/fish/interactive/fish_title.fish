function fish_title
  # emacs' "term" is basically the only term that can't handle it.
  if not set -q INSIDE_EMACS; or string match -vq '*,term:*' -- $INSIDE_EMACS
    # If we're connected via ssh, we print the hostname.
    set -l tsn $TMUX_SESSION_NAME
    set -l ssh
    set -q SSH_TTY
    and set ssh "[$(prompt_hostname | string sub -l 10)]"

    set -l prefix (string trim "$tsn $ssh")

    set -l command (status current-command)
    if test "$command" = fish
      set command
    end
    # An override for the current command is passed as the first parameter.
    # This is used by `fg` to show the true process name, among others.
    if set -q argv[1]
      set command $argv[1]
    end

    echo -- $prefix (string sub -l 20 -- $command) (prompt_pwd -d 1 -D 1)
  end
end
