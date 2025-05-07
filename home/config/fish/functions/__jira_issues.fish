# Defined in /run/user/1000/fish.ViodIT/__jira_issues.fish @ line 2
function __jira_issues
	set -l jql $JIRA_JQL

  if test -z $jql
    set jql (git config --get jira.jql)
    if test $status -ne 0
        return 1
    end
  end

  # Limit 100 because go-jira/Jira is behaving funky for >100
  jira list --limit 100 --query $jql --template view-completion 2>/tmp/jira_issues.err
end
