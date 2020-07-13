#! /usr/bin/env bash
set -e
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

USER_HOME="/home/ubuntu"
ASF_HOME="${USER_HOME}/asf-mirror/asf-mirror-master"
ASF_URL="https://github.com/cmackenzie1/asf-mirror/archive/master.zip"
ASF_APACHE2_CONF="${ASF_HOME}/apache2/asf-mirror.conf"
ASF_APACHE2_README="${ASF_HOME}/README.html"
APACHE2_SITES_AVAILABLE="/etc/apache2/sites-available"
APACHE2_SITES_ENABLED="/etc/apache2/sites-enabled"

echo "Updating APT-GET"
apt-get update -y

echo "Installing apache2 HTTP Server"
apt-get install -y apache2 wget curl unzip

echo "Installing scripts"
mkdir -p ${ASF_HOME}
wget ${ASF_URL} -O ${USER_HOME}/asf-mirror.zip
unzip -o ${USER_HOME}/asf-mirror.zip
chown -R ubuntu:ubuntu ${ASF_HOME}

# Cleanup apache conf file if it already exists
rm -f ${APACHE2_SITES_ENABLED}/apache-mirror.conf
cp ${ASF_APACHE2_CONF} ${APACHE2_SITES_AVAILABLE}/apache-mirror.conf

echo "Linking files"
# ln -s [SOURCE] [DEST]
ln -s ${APACHE2_SITES_AVAILABLE}/apache-mirror.conf ${APACHE2_SITES_ENABLED}/apache-mirror.conf

echo "Restart apache2 server"
service apache2 restart

echo "Ensure file permissions are correct"
cp ${ASF_APACHE2_README} /data/asf/README.html
chgrp www-data /data/asf/

echo "Install cron job"
cp ${ASF_CRONTAB} /etc/cron.d/asf-sync