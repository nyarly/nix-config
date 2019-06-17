# Defined in /tmp/fish.uAbev2/repo-cleanup.fish @ line 1
function repo-cleanup
	for d in (commute list)
    cd $d

    set -l bt (git branch --format='%(if)%(upstream:track)%(then)%(refname:short) %(upstream:short) %(upstream:track)%(end)' --no-merged | grep -v '^\s*$')
    set -l mt (git branch --format='%(if)%(upstream:track)%(then)%(refname:short) %(upstream:short) %(upstream:track)%(end)' | grep master)
    set -l cs (git status --porcelain)

    if test -n "$bt" -o -n "$mt" -o -n "$cs"
      echo $d
      for l in $bt
        echo "  " $l
      end
      for l in $mt
        echo "  " $l
      end
      for l in $cs
        echo "  " $l
      end
      return
    end
  end

  echo All clean!
end
