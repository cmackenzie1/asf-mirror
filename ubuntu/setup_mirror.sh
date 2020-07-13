#! /usr/bin/env bash
set -e
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

APACHE2_CONF_URL="https://raw.githubusercontent.com/cmackenzie1/asf-mirror/master/apache2/asf-mirror.conf"
APACHE2_README_URL="https://raw.githubusercontent.com/cmackenzie1/asf-mirror/master/README.html"
APACHE2_SITES_AVAILABLE="/etc/apache2/sites-available/"
APACHE2_SITES_ENABLED="/etc/apache2/sites-enabled/"

echo "Updating APT-GET"
apt-get update

echo "Installing apache2 HTTP Server"
apt-get install -y apache2 wget curl

# Cleanup apache conf file if it already exists
rm -f /etc/apache2/sites-enabled/apache-mirror.conf

echo "Downloading Apache Conf file"
wget ${APACHE2_CONF_URL}  -O /etc/apache2/sites-available/apache-mirror.conf

echo "Linking files"
# ln -s [SOURCE] [DEST]
ln -s /etc/apache2/sites-available/apache-mirror.conf /etc/apache2/sites-enabled/apache-mirror.conf

echo "Restart apache2 server"
service apache2 restart

echo "Ensure file permissions are correct"
wget ${APACHE2_README_URL} -O /data/asf/README.html
chgrp www-data /data/asf/

echo "Install cron job"
wget ${CRONTAB_ENTRY_URL} -O /etc/cron.d/asf-sync