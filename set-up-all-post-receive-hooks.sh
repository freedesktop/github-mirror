#!/bin/sh
set -x
cd /git
find  -path './users' -prune -o -name config -print | while read repo_config; do
    dir="$(dirname $repo_config)"
    if [ -e $dir/git-daemon-export-ok -a -e $dir/HEAD -a -e $dir/$(awk '{ print $2 }' $dir/HEAD) ]; then
        sh -x /git/bin/set-up-post-receive-hooks.sh "$(dirname $repo_config)"
    fi

done
