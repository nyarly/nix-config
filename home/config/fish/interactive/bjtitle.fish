function bjtitle
  echo (bjid) (jira view (bjid) | grep "^summary:" | sed 's/summary: \(Ops: \)\?//')
end
