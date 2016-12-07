#!/bin/sh
getent passwd github-mirror || useradd -r github-mirror -s /bin/false -d /run/github-mirror
mkdir -p /run/github-mirror
cd /etc/systemd/system
ln -s /git/bin/github-mirror.socket
ln -s /git/bin/github-mirror.service
ln -s /git/bin/close-github-pull-requests.service
ln -s /git/bin/close-github-pull-requests.timer
systemctl daemon-reload
