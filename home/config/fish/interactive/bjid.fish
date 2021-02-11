function bjid --description "Emits the Jira ID for the current branch, if there is one."
	set -l branch (git rev-parse --abbrev-ref HEAD)
  git config --get branch.{$branch}.jira-ticket
end
