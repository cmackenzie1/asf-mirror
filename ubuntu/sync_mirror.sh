umask 022
rsync -avz --delete --exclude "/README.html" --safe-links rsync.apache.org::apache-dist /data/asf