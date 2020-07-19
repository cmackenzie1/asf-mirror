umask 022
NOW=$(date +"%Y-%m-%d")
LOG_FILE="/home/ubuntu/asf-mirror/logs/asf-sync.${NOW}.log"
RSYNC_OPTS="-avz --log-file=${LOG_FILE} --delete --exclude "/README.html" --safe-links"
RSYNC_SOURCE="rsync.apache.org::apache-dist"
RSYNC_DEST="/data/asf"
rsync ${RSYNC_OPTS} ${RSYNC_SOURCE} ${RSYNC_DEST}