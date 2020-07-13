#! /usr/bin/env bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Updating APT-GET"
apt-get update

echo "Installing apache2 HTTP Server"
apt-get install -y apache2

echo "Downloading Apache Conf file"
wget https://raw.githubusercontent.com/cmackenzie1/asf-mirror/master/asf-mirror.conf -O /etc/apache2/sites-available/apache-mirror.conf

echo "Linking files"
rm /etc/apache2/sites-available/apache-mirror.conf || true
ln -s /etc/apache2/sites-available/apache-mirror.conf /etc/apache2/sites-enabled/apache-mirror.conf

echo "Restart apache2 server"
service apache2 restart

echo "Ensure file permissions are correct"
chgrp www-data /data/asf/
