#!/bin/bash

export PATH=$PATH:~/.nix-profile/bin

desc=$( task rc.verbose: rc.report.active.columns:description rc.report.active.labels: limit:1 active )
if [ -n "${desc}" ]; then
  glyph="⏯"
  proj=$( task rc.verbose: rc.report.active.columns:project rc.report.active.labels: limit:1 active )
  id=$( task rc.verbose: rc.report.active.columns:id rc.report.active.labels: limit:1 active )
  due=$( task rc.verbose: rc.report.active.columns:due.relative rc.report.active.labels: limit:1 active )
else
  glyph="⚠"
  desc=$( task rc.verbose: rc.report.next.columns:description rc.report.next.labels:1 limit:1 next )
  id=$( task rc.verbose: rc.report.next.columns:id rc.report.next.labels:1 limit:1 next )
  due=$( task rc.verbose: rc.report.next.columns:due.relative rc.report.next.labels:1 limit:1 next )
fi

echo "$id" > /tmp/tw_polybar_id
echo "$glyph $proj⎰$desc 🕚 $due"
