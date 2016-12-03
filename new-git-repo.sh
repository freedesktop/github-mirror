#!/bin/sh

set -x
cd /git

[ -e "$1" ] && echo "project $1 already exists" && exit 1

umask 2
GIT_DIR="$1" git init-db --shared
chgrp -R $2 "$1"
echo "$3" > "$1"/description
touch "$1"/git-daemon-export-ok
chmod +x "$1"/hooks/update

