#!/bin/bash

set -e

mkdir -p /etc/letsencrypt/
cp options-ssl-apache.conf /etc/letsencrypt/

a2enmod proxy_http
a2enmod cgi
a2enmod ssl
a2dissite "*"
rm /etc/apache2/sites-available/*
cp apache2-conf/* /etc/apache2/sites-available/
a2ensite default
a2ensite proxy
service apache2 restart
echo "OK" > /var/www/OK

exit 0
