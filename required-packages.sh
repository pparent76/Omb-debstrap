#!/bin/bash

set -e

if ! grep "jessie-backports" /etc/apt/sources.list; then
  echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
fi

if ! grep "security.debian.org" /etc/apt/sources.list; then
  echo "deb http://security.debian.org/ jessie/updates main" >> /etc/apt/sources.list
fi

# Fetch official debian keys for Raspbian
cp trusted.gpg.d/* /etc/apt/trusted.gpg.d/

apt-get update

apt-get install -y apt-transport-https
apt-get remove -y resolvconf openresolv network-manager
DEBIAN_FRONTEND=noninteractive apt-get install -y curl ntpdate sudo rsyslog iptables iptables-persistent libcurl4-openssl-dev wget build-essential postfix postfix-mysql postfix-pcre procmail apache2 mysql-server git gnupg openssh-server openssl python-virtualenv python-pip python-lxml python-dev libjpeg-dev tor torsocks dnsutils python-dev libxml2-dev libxslt1-dev zlib1g-dev python-jinja2 python-lxml python-pgpdump spambayes

apt-get install -y certbot -t jessie-backports

service mysql start

exit 0
