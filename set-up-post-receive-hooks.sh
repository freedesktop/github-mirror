#!/bin/sh

cd /git/$1
if [ ! -e git-daemon-export-ok -o ! -e HEAD -o ! -e $(awk '{ print $2 }' HEAD) ]; then
	exit
fi

[ -e hooks/post-receive.d ] && exit

mkdir hooks/post-receive.d
cat <<EOF > hooks/post-receive-new-$$
#!/bin/sh

set -e

for f in hooks/post-receive.d/*; do
	[ -x \$f ] && \$f "\$@"
done

EOF

[ -e hooks/post-receive ] && mv hooks/post-receive hooks/post-receive.d/00-post-receive
ln -sf /git/bin/signal-github-mirror hooks/post-receive.d/01-github

mv hooks/post-receive-new-$$ hooks/post-receive
chmod +x hooks/post-receive
