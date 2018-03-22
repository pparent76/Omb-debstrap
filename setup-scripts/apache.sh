#!/bin/bash

#########################################################################
#This script configures apache web server for Own-Mailbox, web interface
#########################################################################

set -e

. ./config.sh

mkdir -p /etc/letsencrypt/
cp files/options-ssl-apache.conf /etc/letsencrypt/

a2enmod proxy_http
a2enmod cgi
a2enmod ssl
a2dissite "*"
rm /etc/apache2/sites-available/*
cp files/apache2-conf/* /etc/apache2/sites-available/

#Replace MASTER_DOMAIN
sed -i "s/MASTER_DOMAIN/$MASTER_DOMAIN/g"  /etc/apache2/sites-available/https.conf

a2ensite default
a2ensite proxy
service apache2 restart

#Clean up folders
rm -rvf /usr/lib/cgi-bin/*
rm -rvf /var/www/*

#Add OK file
echo "OK" > /var/www/OK

exit 0
