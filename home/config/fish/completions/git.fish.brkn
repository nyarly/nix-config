# extra fish completion for git

set -l pos (contains -i ~/.config/fish/completions $fish_complete_path)

function __fish_git_source_extra_completion -a base
	for dir in $fish_complete_path
		if test -f $dir/$base
			source $dir/$base
			break
		end
	end
end

complete -f -c git -n '__fish_git_needs_command' -a switch -d 'Switch to a branch'
complete -k -f -c git -n '__fish_git_using_command switch; and not contains -- -- (commandline -op)' -a '(__fish_git_branches)'
complete -k -f -c git -n '__fish_git_using_command switch; and not contains -- -- (commandline -op)' -a '(__fish_git_unique_remote_branches)' -d 'Unique Remote Branch'
__fish_git_source_extra_completion git-switch.fish

for dir in $fish_complete_path[(math $pos + 1)..-2]
  if test -f $dir/git.fish
    source $dir/git.fish
    break
  end
end

complete -f -c git -n '__fish_git_needs_command' -a savepoint-merge -d 'Merge a branch, creating a savepoint first'
complete -f -c git -n '__fish_git_needs_command' -a savepoint-reset -d 'Fall back to a savepoint, clean up a bad merge'
complete -f -c git -n '__fish_git_needs_command' -a savepoint-review -d 'Review changes in a merge - usually happens automatically'
complete -f -c git -n '__fish_git_needs_command' -a savepoint-complete -d 'Approve a merge - removes savepoint, pushes to origin'

complete -f -c git -n '__fish_git_using_command savepoint-merge' -a '(git branch -r | grep -v HEAD | sed "s/^[[:space:]]*//")' -d 'Remote branch'

complete -f -c git -n '__fish_git_needs_command' -a jira-branch -d 'Add configuration to the branch that tracks a Jira issue'
complete -f -c git -n '__fish_git_using_command jira-branch' -a '(__cached_jira_issues)'

# This is pulled from more recent Fish (~3.1) so it may become redundant
# Get the path to the generated completions
# If $XDG_DATA_HOME is set, that's it, if not, it will be removed and ~/.local/share will remain.
set -l generated_path $XDG_DATA_HOME/fish/generated_completions ~/.local/share/fish/generated_completions

# We don't want to modify $fish_complete_path here, so we make a copy.
set -l complete_dirs $fish_complete_path

# Remove the path to the generated completions if it is in the list
set -l ind (contains -i -- $generated_path[1] $complete_dirs); and set -e complete_dirs[$ind]

# source git-* commands' autocompletion file if exists
set -l __fish_git_custom_commands_completion
for git_ext in $complete_dirs/git-*.fish
    # ignore this completion as executable does not exists
    set -l cmd (string replace -r '.*/([^/]*)\.fish' '$1' $git_ext)
    not command -q $cmd
    and continue
    # already sourced this git-* completion file from some other dir
    contains -- $cmd $__fish_git_custom_commands_completion
    and continue
    source $git_ext
    set -a __fish_git_custom_commands_completion $cmd
end
