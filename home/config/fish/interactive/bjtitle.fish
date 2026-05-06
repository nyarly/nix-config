function bjtitle
  echo (bjid) (acli jira workitem view --json (bjid) | yq ".fields.summary" | sed 's/^Ops: //')
end
