#!/usr/bin/env sh

export LC_ALL=C
exec sed 's/[[:space:]]*$//' | sed -e :a -e '/^$/{ $D;N;ba; }'
