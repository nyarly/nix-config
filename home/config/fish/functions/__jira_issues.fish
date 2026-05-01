# Defined in /run/user/1000/fish.ViodIT/__jira_issues.fish @ line 2
function __jira_issues
	set -l jql $JIRA_JQL

  if test -z "$jql"
    set jql (git config --get jira.jql)
    if test $status -ne 0
        return 1
    end
  end

  acli jira workitem search --paginate --json -j $jql | jq -r '.[] | "\(.key)\t\(.fields.summary) [\(.fields.status.name)]"'
end
