#!/bin/sh
cd /git
find  -path './users' -prune -o -name config -print | while read repo_config; do
    pushd $(dirname $repo_config) 

    if [ -e git-daemon-export-ok -a -e HEAD -a -e $(awk '{ print $2 }' HEAD) ]; then
        /git/bin/close-github-pull-requests
    fi

    popd
done
