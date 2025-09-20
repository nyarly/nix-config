---
title: {{ format-date now "long" }}
date: {{ format-date now "%FT%T%z" }}
---
{{ content }}

{{format-link (sh 'zk list journal/daily --format "{{filename-stem}}" -s created -n 1') "Previous"}}
