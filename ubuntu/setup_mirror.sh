#! /usr/bin/env bash
set -e
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

USER_HOME="/home/ubuntu"
ASF_HOME="${USER_HOME}/asf-mirror"
ASF_URL="https://github.com/cmackenzie1/asf-mirror/archive/master.zip"
ASF_CRONTAB="${ASF_HOME}/crontab/asf-sync"
ASF_APACHE2_CONF="${ASF_HOME}/apache2/asf-mirror.conf"
ASF_APACHE2_README="${ASF_HOME}/README.html"
APACHE2_SITES_AVAILABLE="/etc/apache2/sites-available"
APACHE2_SITES_ENABLED="/etc/apache2/sites-enabled"

rm -rf ${ASF_HOME}

echo "Updating APT-GET"
apt-get update -y
echo "Installing apache2 HTTP Server"
apt-get install -y apache2 wget curl git 

echo "Installing scripts"
git clone https://github.com/cmackenzie1/asf-mirror.git ${ASF_HOME}
chown -R ubuntu:ubuntu ${ASF_HOME}

# Cleanup apache conf file if it already exists
cp ${ASF_APACHE2_CONF} ${APACHE2_SITES_AVAILABLE}/apache-mirror.conf

echo "Linking files"
# ln -s [SOURCE] [DEST]
rm -f ${APACHE2_SITES_ENABLED}/apache-mirror.conf
ln -s ${APACHE2_SITES_AVAILABLE}/apache-mirror.conf ${APACHE2_SITES_ENABLED}/apache-mirror.conf

echo "Restart apache2 server"
service apache2 restart

echo "Ensure file permissions are correct"
rm -f /data/asf/README.html
ln -s ${ASF_APACHE2_README} /data/asf/README.html || true

echo "Install cron job"
rm -f /etc/cron.d/asf-sync
ln -s ${ASF_CRONTAB} /etc/cron.d/asf-sync || true

echo "Done!"