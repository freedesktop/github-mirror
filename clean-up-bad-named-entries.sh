cd /git
find  -path './users' -prune -o -name config -print | while read repo_config; do
    pushd $(dirname $repo_config) 

    if [ -e git-daemon-export-ok -a -e HEAD -a -e $(awk '{ print $2 }' HEAD) ]; then
        echo cleaning up repo "$(basename $PWD .git)"
	curl --user "fdo-mirror:$(cat /etc/github-mirror/mirror.cfg |grep password | awk -F= '{ print $2 }')" -X DELETE "https://api.github.com/repos/freedesktop/$(basename $PWD .git)"
    fi

    popd
done
