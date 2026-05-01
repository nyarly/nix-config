complete -f -c git -n '__fish_git_using_command savepoint-merge' -a '(git branch -r | grep -v HEAD | sed "s/^[[:space:]]*//")' -d 'Remote branch'
