#!/bin/bash

apt-get update

if [ "$?" -ne "0" ]; then
exit 1;
fi
apt-get install -y apt-transport-https
apt-get remove -y resolvconf openresolv network-manager
apt-get install -y curl sudo libcurl4-openssl-dev build-essential postfix postfix-mysql postfix-pcre procmail apache2 mysql-server git gnupg openssh-server openssl python-virtualenv python-pip python-lxml python-dev libjpeg-dev tor torsocks dnsutils python-dev libxml2-dev libxslt1-dev zlib1g-dev python-jinja2 python-lxml python-pgpdump spambayes

if [ "$?" -ne "0" ]; then
exit 1;
fi

/etc/init.d/mysql start

exit 0;
