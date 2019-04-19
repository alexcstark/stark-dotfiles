#!/bin/bash
set -e
git checkout -q master
git for-each-ref refs/heads/ "--format=%(refname:short)" | while read -r branch; do
    mergebase=$(git merge-base master "$branch")
    mergepoint=$(git rev-parse "$branch^{tree}")
    tempcommit=$(git commit-tree "$mergepoint" -p "$mergebase" -m _)
    cherry=$(git cherry master "$tempcommit")
    if [[ $cherry == "-"* ]] ; then
      if [ "$1" == "-f" ]; then
          git branch -D "$branch"
      else
          echo git branch -D "$branch"
      fi
    fi
done
git checkout -q -

